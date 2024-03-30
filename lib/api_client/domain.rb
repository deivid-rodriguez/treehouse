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

    sig do
      params(body: Query, page_number: T.nilable(Integer), page_size: T.nilable(Integer))
        .returns(T::Enumerable[T.untyped])
    end
    def query(body:, page_number: nil, page_size: nil)
      request = body.dup
      request['pageSize'] = page_size if page_size.present?
      request['pageNumber'] = page_number

      debug_log { "Sending query: #{request}" }
      response = search(request)
      debug_log { "Received response: #{response.body}" }

      response.body
    end

    private

    sig { params(request: Query).returns(Faraday::Response) }
    def search(request)
      @connection.post('listings/residential/_search', request)
    rescue Faraday::Error => e
      raise e, "Failed to search: #{e.message}\n#{e.response.try(:fetch, :body, '<no response>')}"
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
