# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id         :bigint           not null, primary key
#  type       :string           default("Response"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  query_id   :bigint           not null
#
# Indexes
#
#  index_responses_on_query_id  (query_id)
#
# Foreign Keys
#
#  fk_rails_...  (query_id => queries.id)
#

require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  extend T::Sig

  test 'for domain query #query exists' do
    assert_not_nil create(:domain_response).query
  end

  test 'for overpass query #query exists' do
    assert_not_nil create(:overpass_response).query
  end

  test '#fetch! calls #fetch! on the query' do
    test = self
    query = build(:query, :domain, body: '{"query": "body"}')
    response = create(:response, query:)

    # Stub the fetch! method on the query
    # The response should delegate fetching to the query model
    query.define_singleton_method(:fetch!) do |*args|
      test.assert_equal [page_after: nil, page_size: ResponsePage::DEFAULT_PER_PAGE], args
      ResponsePage.new(body: '{"next page": "this is the body"}', request_body: query.body)
    end

    page = response.fetch!
    assert_equal response, page.response
    assert_equal '{"query": "body"}', page.request_body
    assert_equal '{"next page": "this is the body"}', page.body
  end
end
