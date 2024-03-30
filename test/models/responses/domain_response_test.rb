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

    test 'parse complete page' do
      page = build_response_page(:fetched, :complete)
      results = page.parse!
      assert_not_nil(results.first, 'Expected results to be parsed from complete page')
      assert_equal(100, results.count)

      # TODO: more assertions
      #
      # pp results.first&.parseable&.as_json
      #
      # {
      #   "id" => nil,
      #   "external_id" => "16946238",
      #   "description" => "<b></b><br />Register now to view this lovely two bedroom ground floor apartment...",
      #   "bathroom_count" => 1.0,
      #   "bedroom_count" => 2.0,
      #   "carpark_count" => 1,
      #   "building_area" => nil,
      #   "land_area" => nil,
      #   "property_type" => "ApartmentUnitFlat",
      #   "monthly_rent" => 525,
      #   "is_rural" => false,
      #   "is_new" => false,
      #   "slug" => "3-5-cleveland-road-ashwood-vic-3147-16946238",
      #   "listed_at" => "2024-03-30T12:48:06.000Z",
      #   "available_at" => "2024-04-05T00:00:00.000Z",
      #   "last_seen_at" => "2024-03-30T16:15:44.987Z",
      #   "created_at" => nil,
      #   "updated_at" => nil,
      # }
    end

    private

    # rubocop:disable Style/ArgumentsForwarding
    sig { params(args: T.untyped).returns(ResponsePage) }
    def build_response_page(*args) = T.unsafe(self).build(:response_page, :domain, *args)
    # rubocop:enable Style/ArgumentsForwarding
  end
end
