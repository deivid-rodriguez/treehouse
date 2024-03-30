# typed: strict
# frozen_string_literal: true

require 'test_helper'

module Queries
  class OverpassQueryTest < ActiveSupport::TestCase
    extend T::Sig

    test 'fetching a single page response' do
      query = build(:query, :overpass)
      result = VCR.use_cassette 'overpass_query_test/fetch_single_page_response' do
        query.fetch!
      end

      assert result.start_with?(<<~XML), 'Expected response to start with Overpass API XML declaration'
        <?xml version="1.0" encoding="UTF-8"?>
        <osm version="0.6" generator="Overpass API 0.7.62.1 084b4234">
        <note>The data included in this document is from www.openstreetmap.org. \
        The data is made available under ODbL.</note>
      XML
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
