# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: queries
#
#  id             :bigint           not null, primary key
#  body           :text             not null
#  description    :text
#  name           :text             not null
#  queryable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  queryable_id   :string           not null
#
# Indexes
#
#  index_queries_on_queryable_type_and_queryable_id  (queryable_type,queryable_id) UNIQUE
#

require 'test_helper'

class QueryTest < ActiveSupport::TestCase
  extend T::Sig

  test 'domain query #build_response is a DomainResponse' do
    query = create(:query, :domain)
    response = query.build_response
    assert_equal Responses::DomainResponse, response.class
  end

  test 'Overpass query #build_response is an OverpassResponse' do
    query = create(:query, :overpass)
    response = query.build_response
    assert_equal Responses::OverpassResponse, response.class
  end
end
