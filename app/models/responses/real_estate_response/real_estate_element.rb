# typed: strict
# frozen_string_literal: true

require 'delegate'

module Responses
  class RealEstateResponse < Response
    # Represents a single node in the RealEstate.com.au API response
    class RealEstateElement < SimpleDelegator
      include Kernel
      extend T::Generic
      extend T::Sig

      HARD_CODED_IMAGE_SIZE = '1280x1024'

      delegate :inspect, to: :@node
      alias to_s inspect

      sig { params(node: T::Hash[String, T.untyped]).void }
      def initialize(node)
        @node = node
        super(node)
      end

      sig { returns(T::Boolean) }
      def listing?
        !!(@node['__typename'] == 'RentResidentialListing')
      end

      sig { returns(T.nilable(Listing)) }
      def to_listing
        return unless listing?

        Listing.lock.find_or_initialize_by(external_id: "rea-#{external_id}").tap do |listing|
          listing.assign_attributes(attributes)
        end
      end

      sig { returns(T.nilable(String)) }
      def external_id
        @node.fetch('id')
      end

      private

      # @node.keys
      # => [
      #   "inspections",
      #   "_links",
      #   "address",
      #   "id",
      #   "productDepth",
      #   "viewConfiguration",
      #   "listingCompany",
      #   "badge",
      #   "media",
      #   "listers",
      #   "price",
      #   "propertyType",
      #   "generalFeatures",
      #   "propertySizes",
      #   "aboveTheFoldId",
      #   "bond",
      #   "availableDate",
      #   "description",
      # ]

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def attributes
        {
          address_attributes:, description:, bathroom_count:, bedroom_count:, carpark_count:, building_area:,
          land_area:, property_type:, monthly_rent:, is_rural: nil, is_new: nil, slug:, available_at:,
          images_attributes:, last_seen_at: DateTime.now, # TODO: actual fetch time
        }
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def address_attributes
        {
          street: @node.fetch('address').fetch('display').fetch('shortAddress'),
          city: @node.fetch('address').fetch('suburb'),
          state: @node.fetch('address').fetch('state').upcase,
          postcode: @node.fetch('address').fetch('postcode'),
        }
      end

      sig { returns(T.nilable(String)) }
      def description
        @node.fetch('description')
      end

      sig { returns(T.nilable(Numeric)) }
      def bathroom_count
        @node.fetch('generalFeatures').fetch('bathrooms').fetch('value')
      end

      sig { returns(T.nilable(Numeric)) }
      def bedroom_count
        @node.fetch('generalFeatures').fetch('bedrooms').fetch('value')
      end

      sig { returns(T.nilable(Numeric)) }
      def carpark_count
        @node.fetch('generalFeatures').fetch('parkingSpaces').fetch('value')
      end

      sig { returns(T.nilable(Numeric)) }
      def building_area
        area(type: 'building')
      end

      sig { returns(T.nilable(Numeric)) }
      def land_area
        area(type: 'land')
      end

      sig { params(type: String).returns(T.nilable(Numeric)) }
      def area(type:)
        areas = @node.fetch('propertySizes')
        display_value = areas[type]&.fetch('displayValue')
        return unless display_value

        begin
          Integer(display_value.gsub(/\D/, ''))
        rescue TypeError, ArgumentError
          raise "Error parsing #{type} area for listing #{external_id}: #{areas.inspect}"
        end
      end

      sig { returns(T.nilable(String)) }
      def property_type
        @node.fetch('propertyType').fetch('display')
      end

      sig { returns(T.nilable(Integer)) }
      def monthly_rent
        display_price = @node.fetch('price').fetch('display')

        begin
          Integer(display_price.gsub(/\D/, ''))
        rescue TypeError, ArgumentError
          raise "Error parsing display price for listing #{external_id}: #{display_price.inspect}"
        end
      end

      sig { returns(String) }
      def slug
        @node.fetch('_links').fetch('canonical').fetch('path').gsub(%r{\A/|/\z}, '')
      end

      sig { returns(T.nilable(DateTime)) }
      def available_at
        date = @node.fetch('availableDate').fetch('display')
        date.gsub!(/available/i, '')
        try_date_parse(date.squeeze.strip)
      end

      sig { returns(T::Array[T::Hash[String, T.untyped]]) }
      def images_attributes
        media = @node['media']&.fetch('images').presence || []
        media.map.with_index do |image, index|
          template = image.fetch('templatedUrl')
          { url: template.gsub('{size}', HARD_CODED_IMAGE_SIZE), index: }
        end
      end

      sig { params(date: T.nilable(String)).returns(T.nilable(DateTime)) }
      def try_date_parse(date)
        return Time.current.to_datetime if date&.downcase == 'now'

        DateTime.parse(date) if date.present?
      rescue Date::Error
        raise ArgumentError, "Invalid date format: #{date}"
      end
    end
  end
end
