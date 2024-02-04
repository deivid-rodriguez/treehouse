# typed: strict
# frozen_string_literal: true

module APIClient
  # Overpass API client
  class Overpass
    extend T::Sig

    BASE_URL = 'https://overpass-api.de/api'

    sig { void }
    def initialize
      connection = Faraday.new(url: BASE_URL) do |faraday|
        faraday.response :raise_error
      end

      @connection = T.let(connection, Faraday::Connection)
    end

    sig { params(body: String).returns(String) }
    def query(body:)
      fetch_response(body:).body
    end

    private

    sig { params(body: String).returns(Faraday::Response) }
    def fetch_response(body:)
      @connection.post('interpreter', body)
    end
  end
end
