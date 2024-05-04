# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id         :bigint           not null, primary key
#  type       :string           default("Response"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  query_id   :bigint           not null
#
# Indexes
#
#  index_responses_on_query_id  (query_id)
#
# Foreign Keys
#
#  fk_rails_...  (query_id => queries.id)
#

require 'test_helper'

module Responses
  class RealEstateResponseTest < ActiveSupport::TestCase
    extend T::Sig

    EXPECTED_FIRST_LISTING_IMAGE_URLS = T.let(
      %w[
        https://i2.au.reastatic.net/1280x1024/05876697fbf4205bfcfb5bf75941ebc459548be0a5b6e9990f08e267b4a51f0c/image.jpg
        https://i2.au.reastatic.net/1280x1024/b0955a76333f244b4d52e166676efd7b5422fb8a86ca386717f85fa43de3432d/image.jpg
        https://i2.au.reastatic.net/1280x1024/b158cbbd605fb74ac9aaeccbb1c7649268608753695af60836a8041a36c81f51/image.jpg
        https://i2.au.reastatic.net/1280x1024/5aeaa8e988d1dc258011253aab039c4e7d3d9e61edc8ca5c4a9e61a0944ac449/image.jpg
        https://i2.au.reastatic.net/1280x1024/0a11e75853d195c0041858e6b3ae3c70b3bea9df720661da520f2d21ea0d2a7e/image.jpg
        https://i2.au.reastatic.net/1280x1024/3d69dc16498e5e70359b5fb2d7dd7c5720fe07c1103700c7649b20d894f7c0db/image.jpg
        https://i2.au.reastatic.net/1280x1024/24a8b410953f8d754f1d4598228844c29c3bbd5ca0ac353c4e365762bcf0d4cf/image.jpg
        https://i2.au.reastatic.net/1280x1024/65d3df89caa8a5387d64acb4a052a08bc9a321fd96a229f2b3072177dc5be8ce/image.jpg
        https://i2.au.reastatic.net/1280x1024/ca08ca984955bb5a918de557681ab55eea458d977125be78611f363ebe174b4e/image.jpg
      ].freeze,
      T::Array[String],
    )

    test 'parse empty page' do
      page = build_response_page(:fetched)
      results = page.parse!
      assert_nil(results.first, 'Expected no results to be parsed from empty page')
    end

    test 'parse complete page' do
      page = build_response_page(:fetched, :complete)
      results = page.parse!
      assert_not_nil(results.first, 'Expected results to be parsed from complete page')
      assert_equal(25, results.count)

      first_listing = T.let(T.must(results.first).parseable, Listing)
      assert_equal('rea-438929808', first_listing.external_id)
      assert_equal(3.0, first_listing.bathroom_count)
      assert_equal(3.0, first_listing.bedroom_count)
      assert_equal(1, first_listing.carpark_count)
      assert_equal('$1,300 per week', first_listing.price&.display)
      assert_not(first_listing.is_rural)
      assert_not(first_listing.is_new)
      assert_equal('property-apartment-vic-docklands-438929808', first_listing.slug)
      assert_nil(first_listing.listed_at)
      assert_equal(DateTime.strptime('2024-04-23', '%Y-%m-%d'), first_listing.available_at)
      assert_not_nil(first_listing.address, 'Expected address to be decoded, got nil')
      assert_not_empty(first_listing.images, 'Expected images to be decoded')

      first_listing_address = T.must(first_listing.address)
      assert_equal('1014/25 Waterfront Way', first_listing_address.street)
      assert_equal('Docklands', first_listing_address.city)
      assert_equal('VIC', first_listing_address.state)
      assert_equal('3008', first_listing_address.postcode)

      EXPECTED_FIRST_LISTING_IMAGE_URLS.each { |url| assert_includes(first_listing.images.map(&:url), url) }
    end

    test 'parse the same listings twice' do
      page = build_response_page(:fetched, :complete).tap(&:save!)

      results = assert_changes -> { Listing.count }, from: 0, to: 25 do
        page.parse!.each(&:save!).each(&:reload)
      end

      assert_equal(25, results.count)

      first_listing = results.first.parseable
      first_listing.reload
      assert_not_nil(first_listing, 'Expected results to be parsed from single element page')
      assert_equal(first_listing.id, Listing.first&.id, 'Expected the listing to be saved')

      assert_equal('rea-438929808', first_listing.external_id)
      assert_not_nil(first_listing.address, 'Expected address to be decoded, got nil')
      assert_empty(first_listing.geocodes, 'Expected geocodes to be decoded')
      assert_equal(9, first_listing.images.count, 'Expected images to be decoded')

      # Parse the same page again -- it shouldn't recreate the listings
      assert_no_changes -> { Listing.count } do
        page.parse!.each(&:save!)
      end

      first_listing.reload
      assert_equal(9, first_listing.images.count, 'Expected images would be unchanged')
    end

    private

    # rubocop:disable Style/ArgumentsForwarding
    sig { params(args: T.untyped).returns(ResponsePage) }
    def build_response_page(*args) = T.unsafe(self).build(:response_page, :real_estate, *args)
    # rubocop:enable Style/ArgumentsForwarding
  end
end
