# typed: strict
# frozen_string_literal: true

require 'delegate'

module APIClient
  # Domain API client
  class Domain
    extend T::Sig

    Query = T.type_alias { T::Hash[String, T.untyped] }

    # Represents a given page of a response to a query
    class Response < T::Struct
      extend T::Sig

      prop :listings, T::Array[T::Hash[String, T.untyped]]
      prop :page_number, Integer
      prop :page_size, Integer
      prop :total_count, Integer

      sig { returns(T::Boolean) }
      def next_page?
        page_number * page_size < total_count
      end
    end

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
      params(
        body: Query,
        page_number: T.nilable(Integer),
        page_size: T.nilable(Integer),
      )
        .returns(Response)
    end
    def query(body:, page_number: nil, page_size: nil)
      request = body.dup
      request['pageSize'] = page_size if page_size.present?
      request['pageNumber'] = page_number

      response = search(request)

      Response.new(
        listings: response.body,
        page_number: page_number.presence || 1,
        page_size: page_size.presence || 100,
        total_count: Integer(response.headers['X-Total-Count']),
      )
    end

    private

    sig { params(request: Query).returns(Faraday::Response) }
    def search(request)
      debug_log { "Sending query: #{request}" }
      @connection.post('listings/residential/_search', request).tap do |response|
        debug_log { "Received response: #{response.body.inspect.truncate(240)}" }
        debug_log { "Received response headers: #{response.headers.to_a.inspect}" }
      end
    rescue Faraday::Error => e
      raise e, "Failed to search: #{e.message}\n#{e.response.try(:fetch, :body, '<no response>')}"
    end

    sig { params(block: T.proc.returns(T.untyped)).void }
    def debug_log(&block)
      Rails.logger.info { "[#{self.class.name}]: #{block.call}" }
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
