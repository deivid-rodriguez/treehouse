# typed: strict
# frozen_string_literal: true

require 'test_helper'

module Queries
  class RealEstateQueryTest < ActiveSupport::TestCase
    extend T::Sig

    test 'fetching a single page response' do
      query = build(:query, :real_estate)

      VCR.use_cassette 'real_estate_query_test/fetch_single_page_response', preserve_exact_body_bytes: true do
        query.fetch!
      end
    end

    test 'fetching an empty response' do
      query = build(:query, :real_estate, :no_results)

      VCR.use_cassette 'real_estate_query_test/fetch_empty_response', preserve_exact_body_bytes: true do
        query.fetch!
      end
    end
  end
end
