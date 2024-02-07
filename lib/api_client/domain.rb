# typed: strict
# frozen_string_literal: true

require 'delegate'

module APIClient
  # Domain API client
  class Domain
    extend T::Sig

    Query = T.type_alias { T::Hash[String, T.untyped] }

    BASE_URL = 'https://api.domain.com.au/v1/'

    sig { void }
    def initialize
      connection = Faraday.new(url: BASE_URL, headers:) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.response :raise_error
      end

      @connection = T.let(connection, Faraday::Connection)
    end

    sig { params(body: Query).returns(T::Enumerable[T.untyped]) }
    def query(body:)
      post(body:, page_number: 1)
    end

    private

    sig { params(body: Query, page_number: Integer, page_size: Integer).returns(T::Enumerable[T.untyped]) }
    def post(body:, page_number:, page_size: 100)
      request = body.dup
      body['pageSize'] = page_size if page_size.present?
      body['pageNumber'] = page_number

      debug_log { "Sending query: #{body}" }
      response = @connection.post('listings/residential/_search', body)
      debug_log { "Received response: #{response.body}" }

      sleep 1 # Most basic rate limiting
      handle_response(ResponsePresenter.new(response), request:)
    end

    sig { params(response: ResponsePresenter, request: Query).returns(T::Enumerable[T.untyped]) }
    def handle_response(response, request:)
      return response.results if response.page_number * response.page_size >= 1000
      return response.results unless response.next_page?

      remaining_results = post(body: request, page_number: response.page_number + 1, page_size: response.page_size)
      response.results.chain(remaining_results)
    end

    sig { params(block: T.proc.returns(T.untyped)).void }
    def debug_log(&block)
      Rails.logger.debug { "[#{self.class.name}]: #{block.call}" }
    end

    sig { returns(T::Hash[String, String]) }
    def headers
      T.let(
        {
          'Content-Type' => 'application/json',
          'Transfer-Encoding' => 'chunked',
          'X-API-Key' => api_key,
        }.freeze,
        T::Hash[String, String],
      )
    end

    sig { returns(String) }
    def api_key
      @api_key ||= T.let(ENV.fetch('DOMAIN_API_KEY'), T.nilable(String))
    ensure
      raise 'No Domain API key found' if @api_key.blank?
    end
  end
end
