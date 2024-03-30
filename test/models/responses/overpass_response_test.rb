# typed: strict
# frozen_string_literal: true

require 'test_helper'

module Responses
  class OverpassResponseTest < ActiveSupport::TestCase
    extend T::Sig

    test 'parse empty page' do
      page = build_response_page(:fetched)
      results = page.parse!
      assert_nil(results.first, 'Expected no results to be parsed from empty page')
    end

    test 'parse complete page' do
      page = build_response_page(:fetched, :complete)
      results = page.parse!
      assert_not_nil(results.first, 'Expected results to be parsed from complete page')
      assert_equal(133, results.count)

      assert_equal('Coles', results.first&.parseable&.name)
      assert_equal('278111955', results.first&.parseable&.external_id)

      # TODO: more assertions
    end

    private

    # rubocop:disable Style/ArgumentsForwarding
    sig { params(args: T.untyped).returns(ResponsePage) }
    def build_response_page(*args) = T.unsafe(self).build(:response_page, :overpass, *args)
    # rubocop:enable Style/ArgumentsForwarding
  end
end
