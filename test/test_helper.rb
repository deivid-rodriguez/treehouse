# typed: strict
# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'factory_bot'
FactoryBot.find_definitions

module ActiveSupport
  # Add more helper methods to be used by all tests here...
  class TestCase
    # Based on https://github.com/thoughtbot/factory_bot/blob/cf3f21fcbbccbc40849c/GETTING_STARTED.md#testunit
    include FactoryBot::Syntax::Methods

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
  end
end
