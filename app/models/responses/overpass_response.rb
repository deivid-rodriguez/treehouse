# typed: strict
# frozen_string_literal: true

require 'delegate'

module Responses
  # Represents a response from querying the Overpass API
  class OverpassResponse < Response
    extend T::Generic
    extend T::Sig

    Element = type_member { { fixed: OverpassElement } }
    Model = type_member { { fixed: Facility } }

    sig { override.returns(T::Enumerable[Model]) }
    def parse!
      nodes
        .map { |node| OverpassElement.new({}.replace(node)) }
        .map do |node|
          Facility.transaction do
            node.to_facility.tap(&:save!)
          end
        end
    end

    private

    sig { returns(T::Enumerator[Saxerator::Builder::HashElement]) }
    def nodes
      parser.for_tag(:node).lazy
    end

    sig { returns(Saxerator::FullDocument) }
    def parser
      @parser ||= T.let(
        Saxerator.parser(body) do |config|
          config.adapter = :ox
          config.output_type = :hash
          config.put_attributes_in_hash!
          config.symbolize_keys!
        end,
        T.nilable(Saxerator::FullDocument),
      )
    end

    # Represents a single node in the Overpass API response
    class OverpassElement < SimpleDelegator
      include Kernel
      extend T::Sig

      delegate :inspect, to: :@node
      alias to_s inspect

      sig { params(node: T::Hash[Symbol, T.untyped]).void }
      def initialize(node)
        @node = node
        super(node)
      end

      # TODO: associate created facilities with this response, i.e. facilities.build(...)
      # a join table with response_id, parseable_type, parseable_id
      # extract some "Parseable" concern -- a model that can be parsed from a Response model
      # associate each Parseable with the Response it was parsed from
      sig { returns(Facility) }
      def to_facility
        facility = Facility.lock.create_with(name:, address:).find_or_initialize_by(external_id: id)
        facility.geocodes.find_or_initialize_by(address:, latitude:, longitude:)
        facility
      end

      sig { returns(String) }
      def id
        @id ||= T.let(@node.fetch(:id), T.nilable(String))
      end

      sig { returns(T.nilable(String)) }
      def name
        @name ||= T.let(find_tag('name'), T.nilable(String))
      end

      sig { returns(String) }
      def address
        @address ||= T.let(
          [
            address_line1,
            (", #{address_city}" if address_city.present?),
            (" #{address_state}" if address_state.present?),
            (" #{address_postcode}" if address_postcode.present?),
          ].compact.join,
          T.nilable(String),
        )
      end

      sig { returns(String) }
      def address_line1
        @address_line1 ||= T.let(
          [
            ("#{address_unit}/" if address_unit.present?),
            ("#{address_house} " if address_house.present?),
            address_street.presence,
          ].compact.join,
          T.nilable(String),
        )
      end

      sig { returns(T.nilable(String)) }
      def address_unit
        @address_unit ||= T.let(find_tag('addr:unit'), T.nilable(String))
      end

      sig { returns(T.nilable(String)) }
      def address_house
        @address_house ||= T.let(find_tag('addr:housenumber'), T.nilable(String))
      end

      sig { returns(T.nilable(String)) }
      def address_street
        @address_street ||= T.let(find_tag('addr:street'), T.nilable(String))
      end

      sig { returns(T.nilable(String)) }
      def address_city
        @address_city ||= T.let(find_tag('addr:city'), T.nilable(String))
      end

      sig { returns(T.nilable(String)) }
      def address_state
        @address_state ||= T.let(find_tag('addr:state'), T.nilable(String))
      end

      sig { returns(T.nilable(String)) }
      def address_postcode
        @address_postcode ||= T.let(find_tag('addr:postcode'), T.nilable(String))
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
