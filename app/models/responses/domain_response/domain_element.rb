# typed: strict
# frozen_string_literal: true

require 'delegate'

module Responses
  class DomainResponse < Response
    # Represents a single node in the Overpass API response
    class DomainElement < SimpleDelegator
      include Kernel
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

      # TODO: associate created listings with this response, i.e. listings.build(...)
      # a join table with response_id, parseable_type, parseable_id
      # extract some "Parseable" concern -- a model that can be parsed from a Response model
      # associate each Parseable with the Response it was parsed from
      sig { returns(T.nilable(Listing)) }
      def to_listing
        return unless listing?

        Listing.lock.find_or_initialize_by(external_id:).tap { |listing| listing.assign_attributes(attributes) }
      end

      private

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def attributes
        {
          address:, description:, bathroom_count:, bedroom_count:, carpark_count:, building_area:, land_area:,
          property_type:, monthly_rent:, is_rural: rural?, is_new: new?, slug:, listed_at:, available_at:,
          images_attributes:, last_seen_at: DateTime.now, # TODO: actual fetch time
        }
      end

      sig { returns(T.nilable(String)) }
      def external_id
        listing&.fetch('id')&.to_s
      end

      sig { returns(String) }
      def address
        '' # TODO: parse address from separate fields
      end

      sig { returns(T.nilable(String)) }
      def description
        listing&.fetch('summaryDescription')
      end

      sig { returns(T.nilable(Float)) }
      def bathroom_count
        property_details&.fetch('bathrooms')
      end

      sig { returns(T.nilable(Float)) }
      def bedroom_count
        property_details&.fetch('bedrooms')
      end

      sig { returns(T.nilable(Integer)) }
      def carpark_count
        property_details&.fetch('carspaces')
      end

      sig { returns(T.nilable(Float)) }
      def building_area
        property_details&.fetch('buildingArea', nil)
      end

      sig { returns(T.nilable(Float)) }
      def land_area
        property_details&.fetch('landArea', nil)
      end

      sig { returns(T.nilable(String)) }
      def property_type
        property_details&.fetch('propertyType')
      end

      sig { returns(T.nilable(Integer)) }
      def monthly_rent
        # TODO: handle cases when price is missing but minPrice/maxPrice or displayPrice is present
        price_details&.fetch('price', nil).presence
      end

      sig { returns(T.nilable(T::Boolean)) }
      def rural?
        property_details&.fetch('isRural')
      end

      sig { returns(T.nilable(T::Boolean)) }
      def new?
        property_details&.fetch('isNew')
      end

      sig { returns(String) }
      def slug
        listing&.fetch('listingSlug')
      end

      sig { returns(T.nilable(DateTime)) }
      def listed_at
        date = listing&.fetch('dateListed')
        DateTime.iso8601(date) if date.present?
      end

      sig { returns(T.nilable(DateTime)) }
      def available_at
        date = listing&.fetch('dateAvailable')
        DateTime.iso8601(date) if date.present?
      end

      sig { returns(T::Array[T::Hash[String, T.untyped]]) }
      def images_attributes
        media = listing&.fetch('media', nil).presence || []
        media.select! { |m| m.fetch('category') == 'Image' }
        media.map.with_index do |image, index|
          { url: image.fetch('url'), index: }
        end
      end

      sig { returns(T.nilable(T::Hash[String, T.untyped])) }
      def listing
        @listing ||= T.let(@node.fetch('listing'), T.nilable(T::Hash[String, T.untyped]))
      end

      sig { returns(T.nilable(T::Hash[String, T.untyped])) }
      def price_details
        @price_details ||= T.let(listing&.fetch('priceDetails'), T.nilable(T::Hash[String, T.untyped]))
      end

      sig { returns(T.nilable(T::Hash[String, T.untyped])) }
      def property_details
        @property_details ||= T.let(listing&.fetch('propertyDetails'), T.nilable(T::Hash[String, T.untyped]))
      end
    end
  end
end
