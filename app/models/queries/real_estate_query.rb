# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: real_estate_queries
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Queries
  # Represents a query of the Domain API
  class RealEstateQuery < ApplicationRecord
    extend T::Sig
    include Queryable

    CLIENT_TYPE = APIClient::RealEstate
    RESPONSE_TYPE = Responses::RealEstateResponse

    sig { override.params(page_after: T.nilable(ResponsePage), page_size: Integer).returns(ResponsePage) }
    def fetch!(page_after: nil, page_size: ResponsePage::DEFAULT_PER_PAGE)
      raise 'Cannot fetch query with no body' if body.blank?

      page_number = (page_after&.page_number.presence || 0) + 1
      retrieved_at = Time.current
      response_body = client.query(body: JSON.parse(body), page_number:, page_size:)

      ResponsePage.new(
        page_number:, retrieved_at:,
        external_page_id: page_number,
        request_body: body, body: response_body,
        next_page: false, # TODO: Implement pagination for real estate queries
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
