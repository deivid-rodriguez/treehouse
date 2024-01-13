# frozen_string_literal: true

# Based on documentation at https://github.com/que-rb/que/tree/fb9278e728b6aca688b3ec8f5b340042a4942062#usage
class CreateQueSchema < ActiveRecord::Migration[7.1]
  def up
    # Whenever you use Que in a migration, always specify the version you're
    # migrating to. If you're unsure what the current version is, check the
    # changelog.
    Que.migrate!(version: 7)
  end

  def down
    # Migrate to version 0 to remove Que entirely.
    Que.migrate!(version: 0)
  end
end
