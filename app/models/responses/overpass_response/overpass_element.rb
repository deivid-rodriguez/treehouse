# typed: strict
# frozen_string_literal: true

require 'delegate'

module Responses
  class OverpassResponse < Response
    # Represents a single node in the Overpass API response
    class OverpassElement < SimpleDelegator
      include Kernel
      extend T::Generic
      extend T::Sig

      delegate :inspect, to: :@node
      alias to_s inspect

      sig { params(node: T::Hash[Symbol, T.untyped]).void }
      def initialize(node)
        @node = node
        super(node)
      end

      sig { returns(Facility) }
      def to_facility
        facility = Facility.lock.find_or_initialize_by(external_id:)
        facility.assign_attributes(name:, address_attributes:)
        address = Address.build(address_attributes)
        facility.geocodes.joins(:address).find_or_initialize_by(address:, latitude:, longitude:)
        facility
      end

      sig { returns(String) }
      def external_id
        @external_id ||= T.let(@node.fetch(:id), T.nilable(String))
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def address_attributes
        {
          unit: find_tag('addr:unit'),
          house: find_tag('addr:housenumber'),
          street: find_tag('addr:street'),
          city: find_tag('addr:city'),
          state: find_tag('addr:state'),
          postcode: find_tag('addr:postcode'),
        }.transform_values(&:presence)
      end

      sig { returns(T.nilable(String)) }
      def name
        @name ||= T.let(find_tag('name'), T.nilable(String))
      end

      sig { returns(T.nilable(Float)) }
      def latitude
        @latitude ||= T.let(Float(@node.fetch(:lat)), T.nilable(Float))
      end

      sig { returns(T.nilable(Float)) }
      def longitude
        @longitude ||= T.let(Float(@node.fetch(:lon)), T.nilable(Float))
      end

      private

      sig { params(key: String).returns(T.nilable(String)) }
      def find_tag(key)
        @node.fetch(:tag).find { _1[:k] == key }&.fetch(:v)
      end
    end
  end
end
