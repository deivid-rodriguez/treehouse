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

require 'nokogiri'

module Responses
  # Represents a response from querying the RealEstate.com.au API
  class RealEstateResponse < Response
    extend T::Generic
    extend T::Sig

    has_many :listings, through: :parses, source: :parseable, source_type: 'Listing', inverse_of: :responses

    Element = type_member { { fixed: RealEstateElement } }
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

    ARGONAUT_EXCHANGE_ASSIGNMENT_PATTERN = /\A\s*window\.ArgonautExchange\s*=/
    TRAILING_SEMICOLON_PATTERN = /;\s*\z/

    sig { params(body: String).returns(T::Enumerable[Element]) }
    def decode(body)
      argonaut_exchange = extract_argonaut_exchange(body)

      client_cache = JSON.parse(argonaut_exchange.dig('resi-property_listing-experience-web', 'urqlClientCache'))
      data = JSON.parse(client_cache.values.first['data'])
      results = data.dig('rentSearch', 'results', 'exact', 'items')

      results.map { RealEstateElement.new(_1.fetch('listing')) }
    end

    sig { params(body: String).returns(T::Hash[String, T.untyped]) }
    def extract_argonaut_exchange(body)
      # Find all script tags with inner text
      script_tags = Nokogiri::HTML(body).css('script').lazy.map(&:text).compact

      # Find the first script tag that contains the ArgonautExchange assignment
      script = script_tags.find { _1.start_with?(ARGONAUT_EXCHANGE_ASSIGNMENT_PATTERN) }
      raise 'No Argonaut exchange script tag found in body' unless script

      # Remove initial assignment and trailing semicolon
      string = script.gsub(Regexp.union(ARGONAUT_EXCHANGE_ASSIGNMENT_PATTERN, TRAILING_SEMICOLON_PATTERN), '')

      # Parse resulting object
      JSON.parse(string)
    end
  end
end
