# typed: strict
# frozen_string_literal: true

require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  extend T::Sig

  test 'for domain query #query exists' do
    assert_not_nil create(:response, :domain).query
  end

  test 'for overpass query #query exists' do
    assert_not_nil create(:response, :overpass).query
  end
end
