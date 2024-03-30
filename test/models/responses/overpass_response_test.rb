# typed: strict
# frozen_string_literal: true

require 'test_helper'

module Responses
  class OverpassResponseTest < ActiveSupport::TestCase
    extend T::Sig

    test 'parse empty page' do
      page = build_response_page
      results = page.parse!
      assert_nil(results.first, 'Expected no results to be parsed from empty page')
    end

    private

    sig { returns(ResponsePage) }
    def build_response_page = build(:response_page, :overpass, :fetched)
  end
end
