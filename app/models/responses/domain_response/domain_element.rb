# typed: strict
# frozen_string_literal: true

require 'delegate'

# TODO: Extract parts of #to_listing into Listing#attributes=
#       As it is, the method is too long and complex, and it only solves the problem of
#       duplicate images and geocodes for this type of response, but not for other types.
#       Extracting the fix from here to the model would fix both those issues.
#
# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/MethodLength

module Responses
  class DomainResponse < Response
    # Represents a single node in the Domain API response
    class DomainElement < SimpleDelegator
      include Kernel
      extend T::Generic
      extend T::Sig

      delegate :inspect, to: :@node
      alias to_s inspect

      sig { params(node: T::Hash[String, T.untyped]).void }
      def initialize(node)
        @node = node
        super(node)
      end

      sig { returns(T::Boolean) }
      def listing?
        !!(@node['type'] == 'PropertyListing' && @node.key?('listing'))
      end

      sig { returns(T.nilable(Listing)) }
      def to_listing
        return unless listing?

        Listing.lock.includes(:address, :geocodes, :images).find_or_initialize_by(external_id:).tap do |listing|
          listing.assign_attributes(attributes)

          images = listing.images.to_a
          images_attributes.each do |attributes|
            image = images.find { _1.url == attributes.fetch(:url) }
            image.present? ? image.update(attributes) : listing.images.build(attributes)
          end

          coordinates = listing.geocodes.map(&:coordinates)
          geocodes_attributes.each do |geocode_attributes|
            next if coordinates.any?(geocode_attributes.values_at(:latitude, :longitude))

            listing.geocodes << Geocode.build(geocode_attributes)
          end
        end
      end

      sig { returns(T.nilable(String)) }
      def external_id
        "domain-#{listing&.fetch('id')}"
      end

      private

      # TODO: add headline
      sig { returns(T::Hash[Symbol, T.untyped]) }
      def attributes
        {
          address_attributes:, description:, bathroom_count:, bedroom_count:, carpark_count:, building_area:,
          land_area:, property_type:, monthly_rent:, is_rural: rural?, is_new: new?, slug:, listed_at:, available_at:,
          last_seen_at: DateTime.now, # TODO: actual fetch time
        }
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def address_attributes
        {
          unit: listing&.dig('propertyDetails', 'unitNumber'),
          house: listing&.dig('propertyDetails', 'streetNumber'),
          street: listing&.dig('propertyDetails', 'street'),
          city: listing&.dig('propertyDetails', 'suburb'),
          state: listing&.dig('propertyDetails', 'state'),
          postcode: listing&.dig('propertyDetails', 'postcode'),
        }
      end

      sig { returns(T.nilable(String)) }
      def description
        listing&.fetch('summaryDescription')
      end

      sig { returns(T.nilable(Float)) }
      def bathroom_count
        listing&.dig('propertyDetails', 'bathrooms')
      end

      sig { returns(T.nilable(Float)) }
      def bedroom_count
        listing&.dig('propertyDetails', 'bedrooms')
      end

      sig { returns(T.nilable(Integer)) }
      def carpark_count
        listing&.dig('propertyDetails', 'carspaces')
      end

      sig { returns(T.nilable(Float)) }
      def building_area
        listing&.dig('propertyDetails', 'buildingArea')
      end

      sig { returns(T.nilable(Float)) }
      def land_area
        listing&.dig('propertyDetails', 'landArea')
      end

      sig { returns(T.nilable(String)) }
      def property_type
        listing&.dig('propertyDetails', 'propertyType')
      end

      sig { returns(T.nilable(Integer)) }
      def monthly_rent
        # TODO: handle cases when price is missing but minPrice/maxPrice or displayPrice is present
        listing&.dig('priceDetails', 'price').presence
      end

      sig { returns(T.nilable(T::Boolean)) }
      def rural?
        listing&.dig('propertyDetails', 'isRural')
      end

      sig { returns(T.nilable(T::Boolean)) }
      def new?
        listing&.dig('propertyDetails', 'isNew')
      end

      sig { returns(String) }
      def slug
        listing&.fetch('listingSlug')
      end

      sig { returns(T.nilable(DateTime)) }
      def listed_at
        date = listing&.fetch('dateListed')
        try_date_parse(date)
      end

      sig { returns(T.nilable(DateTime)) }
      def available_at
        date = listing&.fetch('dateAvailable')
        try_date_parse(date)
      end

      sig { returns(T::Array[T::Hash[Symbol, T.untyped]]) }
      def images_attributes
        media = listing&.fetch('media', nil).presence || []
        media.select! { |m| m.fetch('category') == 'Image' }
        media.map.with_index do |image, index|
          { url: image.fetch('url'), index: }
        end
      end

      sig { returns(T::Array[T::Hash[Symbol, T.untyped]]) }
      def geocodes_attributes
        [{
          latitude: listing&.dig('propertyDetails', 'latitude'),
          longitude: listing&.dig('propertyDetails', 'longitude'),
        }]
      end

      sig { returns(T.nilable(T::Hash[String, T.untyped])) }
      def listing
        @listing ||= T.let(@node.fetch('listing'), T.nilable(T::Hash[String, T.untyped]))
      end

      sig { params(date: T.nilable(String)).returns(T.nilable(DateTime)) }
      def try_date_parse(date)
        DateTime.iso8601(date) if date.present?
      rescue Date::Error
        raise ArgumentError, "Invalid date format: #{date}"
      end
    end
  end
end
