# typed: strict
# frozen_string_literal: true

require 'test_helper'

module Responses
  class DomainResponseTest < ActiveSupport::TestCase
    extend T::Sig

    test 'parse empty page' do
      page = build_response_page(:fetched)
      results = page.parse!
      assert_nil(results.first, 'Expected no results to be parsed from empty page')
    end

    EXPECTED_FIRST_LISTING_IMAGE_URLS = T.let(
      %w[
        https://bucket-api.domain.com.au/v1/bucket/image/16946238_1_1_240330_014804-w4032-h3024
        https://bucket-api.domain.com.au/v1/bucket/image/16946238_1_1_240330_014804-w4032-h3024
        https://bucket-api.domain.com.au/v1/bucket/image/16946238_2_1_240330_014804-w4032-h3024
        https://bucket-api.domain.com.au/v1/bucket/image/16946238_3_1_240330_014804-w4032-h3024
        https://bucket-api.domain.com.au/v1/bucket/image/16946238_4_1_240330_014804-w4032-h3024
        https://bucket-api.domain.com.au/v1/bucket/image/16946238_5_1_240330_014804-w4032-h3024
      ].freeze,
      T::Array[String],
    )

    test 'parse complete page' do
      page = build_response_page(:fetched, :complete)
      results = page.parse!
      assert_not_nil(results.first, 'Expected results to be parsed from complete page')
      assert_equal(100, results.count)

      first_listing = T.let(T.must(results.first).parseable, Listing)
      assert_equal('16946238', first_listing.external_id)
      assert_equal(1.0, first_listing.bathroom_count)
      assert_equal(2.0, first_listing.bedroom_count)
      assert_equal(1, first_listing.carpark_count)
      assert_equal(525, first_listing.monthly_rent)
      assert_equal(false, first_listing.is_rural)
      assert_equal(false, first_listing.is_new)
      assert_equal('3-5-cleveland-road-ashwood-vic-3147-16946238', first_listing.slug)
      assert_equal(DateTime.strptime('2024-03-30T12:48:06', '%Y-%m-%dT%H:%M:%S'), first_listing.listed_at)
      assert_equal(DateTime.strptime('2024-04-05', '%Y-%m-%d'), first_listing.available_at)
      assert_not_nil(first_listing.address, 'Expected address to be decoded, got nil')
      assert_not_empty(first_listing.images, 'Expected images to be decoded')

      first_listing_address = T.must(first_listing.address)
      assert_equal('3', first_listing_address.unit)
      assert_equal('5', first_listing_address.house)
      assert_equal('Cleveland Road', first_listing_address.street)
      assert_equal('ASHWOOD', first_listing_address.city)
      assert_equal('VIC', first_listing_address.state)
      assert_equal('3147', first_listing_address.postcode)

      EXPECTED_FIRST_LISTING_IMAGE_URLS.each { |url| assert_includes(first_listing.images.map(&:url), url) }
    end

    private

    # rubocop:disable Style/ArgumentsForwarding
    sig { params(args: T.untyped).returns(ResponsePage) }
    def build_response_page(*args) = T.unsafe(self).build(:response_page, :domain, *args)
    # rubocop:enable Style/ArgumentsForwarding
  end
end
