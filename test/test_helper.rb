# typed: strict
# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'factory_bot'
FactoryBot.find_definitions

require 'vcr'
VCR.configure do |config|
  config.hook_into :faraday
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.default_cassette_options = {
    allow_unused_http_interactions: false,
    match_requests_on: %i[method host path body],
  }
end

module ActiveSupport
  # Add more helper methods to be used by all tests here...
  class TestCase
    # Based on https://github.com/thoughtbot/factory_bot/blob/cf3f21fcbbccbc40849c/GETTING_STARTED.md#testunit
    include FactoryBot::Syntax::Methods

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
  end
end
