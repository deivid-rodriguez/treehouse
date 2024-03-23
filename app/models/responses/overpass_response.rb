# typed: strict
# frozen_string_literal: true

module Responses
  # Represents a response from querying the Overpass API
  class OverpassResponse < Response
    extend T::Generic
    extend T::Sig

    Element = type_member { { fixed: OverpassElement } }
    Model = type_member { { fixed: Facility } }

    sig { override.params(page: ResponsePage).returns(T::Enumerable[Parse]) }
    def parse!(page)
      parsed_at = Time.current

      decode(page.body).each_with_index.map do |element, index|
        Parse.new(
          parseable: element.to_facility,
          response_page_element: page.elements.build(external_id: element.external_id, index:, parsed_at:),
        )
      end
    end

    private

    sig { params(body: String).returns(T::Enumerable[Element]) }
    def decode(body)
      parser_for(body).for_tag(:node).lazy.map { |node| OverpassElement.new({}.replace(node)) }
    end

    sig { params(body: String).returns(Saxerator::FullDocument) }
    def parser_for(body)
      Saxerator.parser(body) do |config|
        config.adapter = :ox
        config.output_type = :hash
        config.put_attributes_in_hash!
        config.symbolize_keys!
      end
    end
  end
end
