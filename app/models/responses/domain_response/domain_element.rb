# typed: strict
# frozen_string_literal: true

require 'delegate'

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
        end
      end

      sig { returns(T.nilable(String)) }
      def external_id = "domain-#{listing&.fetch('id')}"

      private

      # TODO: add headline
      sig { returns(T::Hash[Symbol, T.untyped]) }
      def attributes
        {
          address_attributes:, description:, bathroom_count:, bedroom_count:, carpark_count:, building_area:,
          land_area:, property_type:, is_rural: rural?, is_new: new?, slug:, listed_at:, available_at:,
          images_attributes:, geocodes_attributes:, price:,
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
      def description = listing&.fetch('summaryDescription')

      sig { returns(T.nilable(Float)) }
      def bathroom_count = listing&.dig('propertyDetails', 'bathrooms')

      sig { returns(T.nilable(Float)) }
      def bedroom_count = listing&.dig('propertyDetails', 'bedrooms')

      sig { returns(T.nilable(Integer)) }
      def carpark_count = listing&.dig('propertyDetails', 'carspaces')

      sig { returns(T.nilable(Float)) }
      def building_area = listing&.dig('propertyDetails', 'buildingArea')

      sig { returns(T.nilable(Float)) }
      def land_area = listing&.dig('propertyDetails', 'landArea')

      sig { returns(T.nilable(String)) }
      def property_type = listing&.dig('propertyDetails', 'propertyType')

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def price_attributes
        {
          value: listing&.dig('priceDetails', 'price').presence,
          min: listing&.dig('priceDetails', 'priceFrom').presence,
          max: listing&.dig('priceDetails', 'priceTo').presence,
          display: listing&.dig('priceDetails', 'displayPrice').presence,
        }
      end

      sig { returns(Price) }
      def price
        case listing&.fetch('listingType')&.downcase
        when 'rent' then MonthlyRent.new(price_attributes)
        when 'buy' then SalePrice.new(price_attributes)
        else NullPrice.new
        end
      end

      sig { returns(T.nilable(T::Boolean)) }
      def rural? = listing&.dig('propertyDetails', 'isRural')

      sig { returns(T.nilable(T::Boolean)) }
      def new? = listing&.dig('propertyDetails', 'isNew')

      sig { returns(String) }
      def slug = listing&.fetch('listingSlug')

      sig { returns(T.nilable(DateTime)) }
      def listed_at = try_date_parse listing&.fetch('dateListed')

      sig { returns(T.nilable(DateTime)) }
      def available_at = try_date_parse listing&.fetch('dateAvailable')

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
