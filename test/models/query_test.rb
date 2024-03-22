# typed: strict
# frozen_string_literal: true

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
