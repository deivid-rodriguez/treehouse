# typed: strict
# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  # Add more helper methods to be used by all tests here...
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
  end
end
