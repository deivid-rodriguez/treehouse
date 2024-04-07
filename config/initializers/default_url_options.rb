# typed: strict
# frozen_string_literal: true

# Default base URL for the site

app_hosts = []
app_port = nil

# Use APP_HOST and APP_PORT environment variables as default host and port, if set
app_hosts << ENV['APP_HOST'] if ENV['APP_HOST'].present?
app_port = ENV['APP_PORT'] if ENV['APP_PORT'].present?

if Rails.env.test?
  # In test, prefer HOSTNAME > TEST_HOST > APP_HOST
  app_hosts.unshift(ENV['TEST_HOST']) if ENV['TEST_HOST'].present?
  app_hosts.unshift(ENV['HOSTNAME']) if ENV['HOSTNAME'].present?

  # Always use alternate port in test, so dev and test can run simultaneously
  app_port = ENV['TEST_PORT'] if ENV['TEST_PORT'].present?
end

# When `bin/rails server` is invoked, Rails::Server will be defined.
# For all other commands, e.g. `bin/rails generate`, it won't be defined.
# In that case, enforce the presence of APP_HOST, so that the server will only
# run with a host configured, without interfering with general-purpose commands
raise "Couldn't determine default URL, APP_HOST must be set" if Rails.const_defined?('Server') && app_hosts.none?

Rails.application.config.hosts += app_hosts
Rails.application.config.action_controller.default_url_options = { host: app_hosts.first }
Rails.application.config.action_controller.default_url_options[:port] = app_port if app_port.present?
