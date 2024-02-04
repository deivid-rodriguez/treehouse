# typed: strict
# frozen_string_literal: true

module APIClient
  class Domain
    # Handles conversion of Domain responses to the format required
    class ResponsePresenter < SimpleDelegator
      include Kernel
      extend T::Sig

      delegate :body, :headers, to: :@response

      sig { params(response: Faraday::Response).void }
      def initialize(response)
        @response = response
        super(response)
      end

      # If it's lower than the page size (X-Pagination-Pagesize) times the (X-Pagination-Pagenumber),
      # we need to get the next page too
      sig { returns(T::Boolean) }
      def next_page?
        count > (page_size * page_number)
      end

      sig { returns(Integer) }
      def count
        @count ||= T.let(Integer(headers.fetch('x-total-count')), T.nilable(Integer))
      end

      sig { returns(T::Enumerable[T.untyped]) }
      def results
        # Pages can be returned bigger than the requested page size, so use take(page_size)
        @results ||= T.let(body.take(page_size), T.nilable(T::Enumerable[T.untyped]))
      end

      sig { returns(Integer) }
      def page_number
        @page_number ||= T.let(Integer(headers.fetch('x-pagination-pagenumber')), T.nilable(Integer))
      end

      sig { returns(Integer) }
      def page_size
        @page_size ||= T.let(Integer(headers.fetch('x-pagination-pagesize')), T.nilable(Integer))
      end
    end
  end
end
