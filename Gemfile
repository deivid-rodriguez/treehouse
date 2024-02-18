# frozen_string_literal: true

source 'https://rubygems.org'

# Use ruby version from ruby-version file
ruby "~> #{File.read(File.expand_path('.ruby-version', __dir__)).strip}"

source 'https://gem.fury.io/sorbet-multiarch/' do
  gem 'sorbet-static', group: :development
end

gem 'sorbet', group: :development
gem 'sorbet-runtime'
gem 'tapioca', require: false, group: %i[development test]

gem 'active_decorator'
gem 'faraday', '~> 2.9'
gem 'good_job', '~> 3.22'
gem 'ox', '~> 2.14'
gem 'paper_trail'
gem 'prosopite'
gem 'rails_admin',
  git: 'https://github.com/railsadminteam/rails_admin.git',
  ref: 'af7414a98aa87cfe90d79cb0ed64962fb34c58f4'
gem 'rake', '~> 13.1'
gem 'saxerator'
gem 'vite_rails', '~> 3.0'

# Only some parts of Rails are loaded
gem 'actionpack', '~> 7.1'
gem 'actionview', '~> 7.1'
gem 'activemodel', '~> 7.1'
gem 'activerecord', '~> 7.1'
gem 'activesupport', '~> 7.1'
# gem 'actionmailer', '~> 7.1'
gem 'actioncable', '~> 7.1'
gem 'activejob', '~> 7.1'
gem 'activestorage', '~> 7.1'
# gem 'actionmailbox', '~> 7.1'
# gem 'actiontext', '~> 7.1'
gem 'railties', '~> 7.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
gem 'pg_query'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'capybara', require: false
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails', '~> 6.4', require: false
  gem 'faker', '~> 3.2', require: false
  gem 'pry', require: false
  gem 'pry-byebug', require: false
  gem 'pry-rails', require: false
  gem 'rubocop', '~> 1.59', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-sorbet', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem 'rack-mini-profiler'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end
