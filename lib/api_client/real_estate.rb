# typed: strict
# frozen_string_literal: true

require 'delegate'

module APIClient
  # RealEstate.com.au API client
  class RealEstate
    extend T::Sig

    BASE_URL = 'https://www.realestate.com.au'

    sig { void }
    def initialize
      @scrapfly_client = T.let(Scrapfly.new, Scrapfly)
    end

    sig do
      params(body: T::Hash[String, T.untyped], page_number: T.nilable(Integer), page_size: T.nilable(Integer))
        .returns(String)
    end
    def query(body:, page_number: nil, page_size: nil) # rubocop:disable Lint/UnusedMethodArgument
      request = Request.from(hash: body)
      request.page_number = page_number if page_number.present?
      response = @scrapfly_client.scrape("#{BASE_URL}/#{request.url_path}").body
      response.dig('result', 'content')
    end

    # Represents the query to be sent to the API
    class Request < T::Struct
      extend T::Sig

      const :listing_type, String
      const :property_types, T::Array[String]
      const :min_bedrooms, T.nilable(Integer)
      const :max_bedrooms, T.nilable(Integer)
      const :min_bathrooms, T.nilable(Numeric)
      const :min_price, T.nilable(Integer)
      const :max_price, T.nilable(Integer)
      const :min_carparks, T.nilable(Integer)
      const :location, T::Array[String]
      prop :page_number, Integer, default: 1

      sig { params(hash: T::Hash[String, T.untyped]).returns(T.attached_class) }
      def self.from(hash:)
        args = hash.symbolize_keys.slice(
          :min_bedrooms, :max_bedrooms,
          :min_price, :max_price,
          :min_bathrooms, :min_carparks,
          :listing_type, :location, :property_types,
        )

        args[:property_types] ||= []

        new(**args)
      end

      sig { params(value: T.nilable(String)).returns(T.nilable(String)) }
      def sanitize(value)
        value&.downcase&.tr('^a-z0-9-,', '+')
      end

      sig { returns(String) }
      def url_path_slug
        [
          (['property', property_types.first] if property_types.present?),
          'with', min_bedrooms, 'bedrooms',
          'between', min_price, max_price,
          'in', location.first,
        ].flatten.compact.map { sanitize(_1.to_s) }.join('-')
      end

      sig { returns(String) }
      def url_path
        params = {
          numParkingSpaces: min_carparks,
          numBaths: min_bathrooms,
          maxBeds: max_bedrooms,
          misc: 'ex-deposit-taken',
          source: 'refinement',
        }

        "#{listing_type}/#{url_path_slug}/list-#{page_number}?#{params.compact.map { |k, v| "#{k}=#{v}" }.join('&')}"
      end
    end
  end
end
