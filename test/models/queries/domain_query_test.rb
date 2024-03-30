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

    # test 'fetching a multiple page response'
  end
end
