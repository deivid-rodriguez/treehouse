# typed: strict
# frozen_string_literal: true

require 'test_helper'

module Queries
  class DomainQueryTest < ActiveSupport::TestCase
    extend T::Sig

    test 'fetching a single page response' do
      query = build(:query, :domain)

      VCR.use_cassette 'domain_query_test/fetch_single_page_response' do
        query.fetch!
      end
    end

    test 'fetching a second page response' do
      response_page = build(:response_page, :domain, :first)

      VCR.use_cassette 'domain_query_test/fetch_second_page_response' do
        response_page.response.query.fetch!(page_after: response_page)
      end
    end
  end
end
