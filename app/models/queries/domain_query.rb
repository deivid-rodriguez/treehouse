# typed: strict
# frozen_string_literal: true

module Queries
  # Represents a query of the Domain API
  class DomainQuery < ApplicationRecord
    extend T::Sig
    include Queryable

    CLIENT_TYPE = APIClient::Domain
    RESPONSE_TYPE = Responses::DomainResponse

    sig { override.params(page_after: T.nilable(ResponsePage), page_size: Integer).returns(String) }
    def fetch!(page_after: nil, page_size: ResponsePage::DEFAULT_PER_PAGE)
      page_number = (page_after&.page_number.presence || 0) + 1
      client.query(body: JSON.parse(body), page_number:, page_size:).to_json
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
