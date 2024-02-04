# typed: strict
# frozen_string_literal: true

module Responses
  # Represents a response from querying the Overpass API
  class OverpassResponse < Response
    extend T::Generic
    extend T::Sig

    Element = type_member { { fixed: OverpassElement } }
    Model = type_member { { fixed: Facility } }

    sig { override.returns(T::Enumerable[Model]) }
    def parse!
      elements.map do |node|
        Facility.transaction do
          node.to_facility.tap(&:save!)
        end
      end
    end

    private

    sig { returns(T::Enumerable[Element]) }
    def elements
      parser.for_tag(:node).lazy.map { |node| OverpassElement.new({}.replace(node)) }
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
  end
end
