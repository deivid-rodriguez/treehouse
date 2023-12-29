# frozen_string_literal: true

require 'active_record'
require 'active_support/configuration_file'
require 'active_support/core_ext/string/filters'
require 'active_support/deprecation'

ActiveRecord::Tasks::DatabaseTasks.env = 'default_env'
ActiveRecord::Tasks::DatabaseTasks.root = File.expand_path('..', __dir__)
ActiveRecord::Tasks::DatabaseTasks.db_dir = File.expand_path('../db', __dir__)
ActiveRecord::Tasks::DatabaseTasks.migrations_paths = [File.expand_path('../db/migrate', __dir__)]
ActiveRecord::Tasks::DatabaseTasks.seed_loader = Object.new.tap do |loader|
  def loader.load_seed
    seeds_file = "#{ActiveRecord::Tasks::DatabaseTasks.db_dir}/seeds.rb"
    load seeds_file if File.exist?(seeds_file)
  end
end

ActiveRecord::Tasks::DatabaseTasks.database_configuration = {
  default_env: ENV.fetch('DATABASE_URL')
}

db_namespace = namespace :db do
  desc 'Set the environment value for the database'
  task 'environment:set' => :load_config do
    connection = ActiveRecord::Tasks::DatabaseTasks.migration_connection
    raise ActiveRecord::EnvironmentStorageError unless connection.internal_metadata.enabled?

    connection.internal_metadata.create_table_and_set_flags(connection.migration_context.current_environment)
  end

  desc 'Ensure the environment is not protected before continuing'
  task check_protected_environments: :load_config do
    ActiveRecord::Tasks::DatabaseTasks.check_protected_environments!
  end

  task load_config: :environment do
    if ActiveRecord::Base.configurations.empty?
      ActiveRecord::Base.configurations = ActiveRecord::Tasks::DatabaseTasks.database_configuration
    end

    ActiveRecord::Migrator.migrations_paths = ActiveRecord::Tasks::DatabaseTasks.migrations_paths
    ActiveRecord::Base.establish_connection
    Que.connection = ActiveRecord
  end

  namespace :create do
    task all: :load_config do
      ActiveRecord::Tasks::DatabaseTasks.create_all
    end
  end

  desc <<~DESC.squish
    Create the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:create:all to create
    all databases in the config). Without RAILS_ENV or when RAILS_ENV is development, it defaults to creating the
    development and test databases, except when DATABASE_URL is present.
  DESC
  task create: [:load_config] do
    ActiveRecord::Tasks::DatabaseTasks.create_current
  end

  namespace :drop do
    task all: %i[load_config check_protected_environments] do
      ActiveRecord::Tasks::DatabaseTasks.drop_all
    end
  end

  desc <<~DESC.squish
    Drop the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:drop:all to drop all
    databases in the config). Without RAILS_ENV or when RAILS_ENV is development, it defaults to dropping the
    development and test databases, except when DATABASE_URL is present.
  DESC
  task drop: %i[load_config check_protected_environments] do
    db_namespace['drop:_unsafe'].invoke
  end

  task 'drop:_unsafe' => [:load_config] do
    ActiveRecord::Tasks::DatabaseTasks.drop_current
  end

  namespace :purge do
    task all: %i[load_config check_protected_environments] do
      ActiveRecord::Tasks::DatabaseTasks.purge_all
    end
  end

  desc 'Truncates tables of each database for current environment'
  task truncate_all: %i[load_config check_protected_environments] do
    ActiveRecord::Tasks::DatabaseTasks.truncate_all
  end

  desc <<~DESC.squish
    Empty the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:purge:all to purge
    all databases in the config). Without RAILS_ENV it defaults to purging the development and test databases, except
    when DATABASE_URL is present.
  DESC
  task purge: %i[load_config check_protected_environments] do
    ActiveRecord::Tasks::DatabaseTasks.purge_current
  end

  desc 'Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog).'
  task migrate: :load_config do
    db_configs = ActiveRecord::Base.configurations.configs_for(env_name: ActiveRecord::Tasks::DatabaseTasks.env)

    if db_configs.size == 1
      ActiveRecord::Tasks::DatabaseTasks.migrate
    else
      mapped_versions = ActiveRecord::Tasks::DatabaseTasks.db_configs_with_versions(db_configs)

      mapped_versions.sort.each do |version, db_configs|
        db_configs.each do |db_config|
          ActiveRecord::Tasks::DatabaseTasks.with_temporary_connection(db_config) do
            ActiveRecord::Tasks::DatabaseTasks.migrate(version)
          end
        end
      end
    end

    db_namespace['_dump'].invoke
  end

  # IMPORTANT: This task won't dump the schema if ActiveRecord.dump_schema_after_migration is set to false
  task :_dump do
    db_namespace['schema:dump'].invoke if ActiveRecord.dump_schema_after_migration
    # Allow this task to be called as many times as required. An example is the
    # migrate:redo task, which calls other two internally that depend on this one.
    db_namespace['_dump'].reenable
  end

  namespace :migrate do
    desc 'Roll back the database one migration and re-migrate up (options: STEP=x, VERSION=x).'
    task redo: :load_config do
      ActiveRecord::Tasks::DatabaseTasks.raise_for_multi_db(command: 'db:migrate:redo')

      raise 'Empty VERSION provided' if ENV['VERSION'] && ENV['VERSION'].empty?

      if ENV['VERSION']
        db_namespace['migrate:down'].invoke
        db_namespace['migrate:up'].invoke
      else
        db_namespace['rollback'].invoke
        db_namespace['migrate'].invoke
      end
    end

    # desc 'Resets your database using your migrations for the current environment'
    task reset: ['db:drop', 'db:create', 'db:migrate']

    desc 'Run the "up" for a given migration VERSION.'
    task up: :load_config do
      ActiveRecord::Tasks::DatabaseTasks.raise_for_multi_db(command: 'db:migrate:up')

      raise 'VERSION is required' if !ENV['VERSION'] || ENV['VERSION'].empty?

      ActiveRecord::Tasks::DatabaseTasks.check_target_version

      ActiveRecord::Tasks::DatabaseTasks.migration_connection.migration_context.run(
        :up,
        ActiveRecord::Tasks::DatabaseTasks.target_version
      )
      db_namespace['_dump'].invoke
    end

    desc 'Run the "down" for a given migration VERSION.'
    task down: :load_config do
      ActiveRecord::Tasks::DatabaseTasks.raise_for_multi_db(command: 'db:migrate:down')

      if !ENV['VERSION'] || ENV['VERSION'].empty?
        raise 'VERSION is required - To go down one migration, use db:rollback'
      end

      ActiveRecord::Tasks::DatabaseTasks.check_target_version

      ActiveRecord::Tasks::DatabaseTasks.migration_connection.migration_context.run(
        :down,
        ActiveRecord::Tasks::DatabaseTasks.target_version
      )
      db_namespace['_dump'].invoke
    end

    desc 'Display status of migrations'
    task status: :load_config do
      ActiveRecord::Tasks::DatabaseTasks.with_temporary_connection_for_each do
        ActiveRecord::Tasks::DatabaseTasks.migrate_status
      end
    end
  end

  desc 'Roll the schema back to the previous version (specify steps w/ STEP=n).'
  task rollback: :load_config do
    ActiveRecord::Tasks::DatabaseTasks.raise_for_multi_db(command: 'db:rollback')
    raise 'VERSION is not supported - To rollback a specific version, use db:migrate:down' if ENV['VERSION']

    step = ENV['STEP'] ? ENV['STEP'].to_i : 1

    ActiveRecord::Tasks::DatabaseTasks.migration_connection.migration_context.rollback(step)

    db_namespace['_dump'].invoke
  end

  # desc 'Pushes the schema to the next version (specify steps w/ STEP=n).'
  task forward: :load_config do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1

    ActiveRecord::Tasks::DatabaseTasks.migration_connection.migration_context.forward(step)

    db_namespace['_dump'].invoke
  end

  namespace :reset do
    task all: ['db:drop', 'db:setup']
  end

  desc 'Drop and recreate all databases from their schema for the current environment and load the seeds.'
  task reset: ['db:drop', 'db:setup']

  # desc "Retrieve the charset for the current environment's database"
  task charset: :load_config do
    puts ActiveRecord::Tasks::DatabaseTasks.charset_current
  end

  # desc "Retrieve the collation for the current environment's database"
  task collation: :load_config do
    puts ActiveRecord::Tasks::DatabaseTasks.collation_current
  rescue NoMethodError
    warn 'Sorry, your database adapter is not supported yet. Feel free to submit a patch.'
  end

  # desc "Raises an error if there are pending migrations"
  task abort_if_pending_migrations: :load_config do
    pending_migrations = []

    ActiveRecord::Tasks::DatabaseTasks.with_temporary_connection_for_each do |conn|
      pending_migrations << conn.migration_context.open.pending_migrations
    end

    pending_migrations = pending_migrations.flatten!

    if pending_migrations.any?
      puts "You have #{pending_migrations.size} pending #{pending_migrations.size > 1 ? 'migrations:' : 'migration:'}"

      pending_migrations.each do |pending_migration|
        puts format('  %<version>4d %<name>s', version: pending_migration.version, name: pending_migration.name)
      end

      abort %(Run `bin/rails db:migrate` to update your database then try again.)
    end
  end

  namespace :setup do
    task all: ['db:create', :environment, 'db:schema:load', :seed]
  end

  desc <<~DESC.squish
    Create all databases, load all schemas, and initialize with the seed data (use db:reset to also drop all
    databases first)
  DESC
  task setup: ['db:create', :environment, 'db:schema:load', :seed]

  desc 'Run setup if database does not exist, or run migrations if it does'
  task prepare: :load_config do
    ActiveRecord::Tasks::DatabaseTasks.prepare_all
  end

  desc 'Load the seed data from db/seeds.rb'
  task seed: :load_config do
    db_namespace['abort_if_pending_migrations'].invoke
    ActiveRecord::Tasks::DatabaseTasks.load_seed
  end

  namespace :seed do
    desc 'Truncate tables of each database for current environment and load the seeds'
    task replant: %i[load_config truncate_all seed]
  end

  namespace :schema do
    desc <<~DESC.squish
      Create a database schema file (either db/schema.rb or db/structure.sql, depending on `ENV['SCHEMA_FORMAT']` or
      `config.active_record.schema_format`)
    DESC
    task dump: :load_config do
      ActiveRecord::Tasks::DatabaseTasks.with_temporary_connection_for_each do |conn|
        db_config = conn.pool.db_config
        schema_format = ENV.fetch('SCHEMA_FORMAT', ActiveRecord.schema_format).to_sym
        ActiveRecord::Tasks::DatabaseTasks.dump_schema(db_config, schema_format)
      end

      db_namespace['schema:dump'].reenable
    end

    desc <<~DESC.squish
      Load a database schema file (either db/schema.rb or db/structure.sql, depending on `ENV['SCHEMA_FORMAT']` or
      `config.active_record.schema_format`) into the database
    DESC
    task load: %i[load_config check_protected_environments] do
      ActiveRecord::Tasks::DatabaseTasks.load_schema_current(ActiveRecord.schema_format, ENV.fetch('SCHEMA', nil))
    end

    namespace :cache do
      desc 'Create a db/schema_cache.yml file.'
      task dump: :load_config do
        ActiveRecord::Tasks::DatabaseTasks.with_temporary_connection_for_each do |conn|
          db_config = conn.pool.db_config
          filename = ActiveRecord::Tasks::DatabaseTasks.cache_dump_filename(
            db_config.name,
            schema_cache_path: db_config.schema_cache_path
          )

          ActiveRecord::Tasks::DatabaseTasks.dump_schema_cache(conn, filename)
        end
      end

      desc 'Clear a db/schema_cache.yml file.'
      task clear: :load_config do
        ActiveRecord::Base.configurations.configs_for(env_name: ActiveRecord::Tasks::DatabaseTasks.env).each do |config|
          filename = ActiveRecord::Tasks::DatabaseTasks.cache_dump_filename(
            config.name,
            schema_cache_path: config.schema_cache_path
          )
          ActiveRecord::Tasks::DatabaseTasks.clear_schema_cache(filename)
        end
      end
    end
  end
end
