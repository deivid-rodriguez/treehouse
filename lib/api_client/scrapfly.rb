# typed: strict
# frozen_string_literal: true

require 'faraday/gzip'

module APIClient
  # Base class for API clients that proxy requests via Scrapfly
  class Scrapfly
    extend T::Sig

    BASE_URL = 'https://api.scrapfly.io'

    sig { void }
    def initialize
      connection = Faraday.new(url: BASE_URL, params:) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.request :gzip
        faraday.response :raise_error
      end

      @connection = T.let(connection, Faraday::Connection)
    end

    # The first parameter is the URL to be scraped -- it must include all query string parameters already.
    sig do
      params(
        url: String,
        method: T.any(String, Symbol),
        body: T.nilable(String),
        headers: T::Hash[T.any(String, Symbol), String],
      ).returns(T.untyped)
    end
    def scrape(url, method: :get, body: nil, headers: {})
      @connection.run_request(method, 'scrape', (body unless method == :get), scrapfly_headers) do |request|
        request.params.update(params.merge(url:, headers:))
      end
    end

    private

    sig { returns(T::Hash[Symbol, String]) }
    def params
      { key: api_key, asp: true }
    end

    sig { returns(T::Hash[Symbol, String]) }
    def scrapfly_headers
      { 'accept-encoding': 'gzip' }
    end

    sig { returns(String) }
    def api_key
      @api_key ||= T.let(ENV.fetch('SCRAPFLY_API_KEY'), T.nilable(String))
    ensure
      raise 'No Scrapfly API key found' if @api_key.blank?
    end
  end
end
