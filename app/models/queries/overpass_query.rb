# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: overpass_queries
#
#  id            :bigint           not null, primary key
#  facility_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

module Queries
  # Represents a query of the Overpass API
  class OverpassQuery < ApplicationRecord
    extend T::Sig
    include Queryable

    CLIENT_TYPE = APIClient::Overpass
    RESPONSE_TYPE = Responses::OverpassResponse

    validates :facility_type, presence: true

    sig { override.params(page_after: T.nilable(ResponsePage), page_size: Integer).returns(ResponsePage) }
    def fetch!(page_after: nil, page_size: ResponsePage::DEFAULT_PER_PAGE) # rubocop:disable Lint/UnusedMethodArgument
      raise "Overpass queries are single page, can't fetch page after '#{page_after.inspect}'" unless page_after.nil?

      retrieved_at = Time.current
      response_body = client.query(body:)

      ResponsePage.new(
        page_number: 1,
        retrieved_at:,
        request_body: body,
        body: response_body,
        next_page: false,
      )
    end

    sig { override.returns(T.untyped) }
    def response_type
      RESPONSE_TYPE
    end

    private

    sig { returns(CLIENT_TYPE) }
    def client
      @client ||= T.let(CLIENT_TYPE.new, T.nilable(CLIENT_TYPE))
    end
  end
end
