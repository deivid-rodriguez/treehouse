# typed: strict
# frozen_string_literal: true

module Queries
  # Represents a query of the Overpass API
  class OverpassQuery < ApplicationRecord
    extend T::Sig
    include Queryable

    CLIENT_TYPE = APIClient::Overpass

    validates :facility_type, presence: true

    sig { returns(Query) }
    def fetch!
      client.query(body:)
    end

    private

    sig { returns(CLIENT_TYPE) }
    def client
      @client ||= T.let(CLIENT_TYPE.new, T.nilable(CLIENT_TYPE))
    end
  end
end
