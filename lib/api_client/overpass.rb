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
      # TODO: parse the response -- currently it returns the XML response as a string
      fetch_response(body:).body
    end

    private

    sig { params(body: String).returns(Faraday::Response) }
    def fetch_response(body:)
      @connection.post('interpreter', body)
    rescue Faraday::Error => e
      handle_error(e)
      raise
    end

    sig { params(error: Faraday::Error).void }
    def handle_error(error)
      Rails.logger.error <<~MESSAGE.chomp
        Overpass API request failed with error: #{error.class}:

        Response Headers:
        ---
        #{error.response_headers}
        ---

        Response body:
        ---
        #{error.response_body}
        ---
      MESSAGE
    end
  end
end
