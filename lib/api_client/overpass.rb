# typed: strict
# frozen_string_literal: true

module APIClient
  # Overpass API client
  class Overpass
    BASE_URL = 'https://overpass-api.de/api'

    def initialize
      @connection = Faraday.new(url: BASE_URL) do |faraday|
        faraday.response :raise_error
      end
    end

    def query(body:)
      # TODO: parse the response -- currently it returns the XML response as a string
      fetch_response(body:).body
    end

    private

    def fetch_response(body:)
      @connection.post('interpreter', body)
    rescue Faraday::Error => e
      handle_error(e)
      raise
    end

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
