# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id         :bigint           not null, primary key
#  type       :string           default("Response"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  query_id   :bigint           not null
#
# Indexes
#
#  index_responses_on_query_id  (query_id)
#
# Foreign Keys
#
#  fk_rails_...  (query_id => queries.id)
#

module Responses
  # Represents a response from querying the Domain API
  class DomainResponse < Response
    extend T::Generic
    extend T::Sig

    has_many :listings, through: :parses, source: :parseable, source_type: 'Listing', inverse_of: :responses

    Element = type_member { { fixed: DomainElement } }
    Model = type_member { { fixed: Listing } }

    sig { override.params(page: ResponsePage).returns(T::Enumerable[Parse]) }
    def parse!(page)
      decode(page.body).select(&:listing?).each_with_index.map do |element, index|
        Parse.new(
          parseable: element.to_listing,
          response_page_element: page.elements
            .create_with(external_id: element.external_id)
            .find_or_initialize_by(index:),
        )
      end
    end

    private

    sig { params(body: String).returns(T::Enumerable[Element]) }
    def decode(body)
      JSON.parse(body).map { |element| DomainElement.new({}.replace(element)) }
    end
  end
end
