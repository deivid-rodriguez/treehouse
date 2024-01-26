# typed: strict
# frozen_string_literal: true

module Queries
  # Represents a query of the Overpass API
  class OverpassQuery < ApplicationRecord
    include Queryable

    CLIENT_TYPE = APIClient::Overpass

    validates :facility_type, presence: true

    def fetch!
      client.query(body:)
    end

    private

    def client
      @client ||= CLIENT_TYPE.new
    end
  end
end
