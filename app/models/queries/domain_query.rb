# typed: strict
# frozen_string_literal: true

module Queries
  # Represents a query of the Domain API
  class DomainQuery < ApplicationRecord
    extend T::Sig
    include Queryable

    CLIENT_TYPE = APIClient::Domain
    RESPONSE_TYPE = Responses::DomainResponse

    sig { returns(RESPONSE_TYPE) }
    def fetch!
      responses.build(body: client.query(body: JSON.parse(body)).to_json, type: RESPONSE_TYPE.name)
    end

    private

    sig { returns(CLIENT_TYPE) }
    def client
      @client ||= T.let(CLIENT_TYPE.new, T.nilable(CLIENT_TYPE))
    end
  end
end
