# typed: strict
# frozen_string_literal: true

module Responses
  # Represents a response from querying the Domain API
  class DomainResponse < Response
    extend T::Generic
    extend T::Sig

    Element = type_member { { fixed: DomainElement } }
    Model = type_member { { fixed: Listing } }

    sig { override.returns(T::Enumerable[Model]) }
    def parse!
      elements.select(&:listing?).map do |element|
        Listing.transaction do
          element.to_listing.tap(&:save!)
        end
      end
    end

    private

    sig { returns(T::Enumerable[Element]) }
    def elements
      JSON.parse(body).map { |element| DomainElement.new({}.replace(element)) }
    end
  end
end
