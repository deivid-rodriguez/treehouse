# typed: strict
# frozen_string_literal: true

require 'test_helper'

module Queries
  class OverpassQueryTest < ActiveSupport::TestCase
    extend T::Sig

    test 'fetching a single page response' do
      query = build(:query, :overpass)
      puts 'before'
      query.fetch!
      puts 'after'
    end

    test 'fetching a multiple page response is not possible' do
      query = build(:query, :overpass)
      page = build(:response_page, :first, response: build(:response, query:))

      assert_raises(match: /overpass queries are single page/i) do
        query.fetch!(page_after: page)
      end
    end
  end
end
