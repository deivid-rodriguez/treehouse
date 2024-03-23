# typed: strict
# frozen_string_literal: true

require 'test_helper'

class GeocodeTest < ActiveSupport::TestCase
  extend T::Sig

  test 'with facility #target exists' do
    assert_not_nil create(:geocode, :with_facility).target
  end

  test 'with listing #target exists' do
    assert_not_nil create(:geocode, :with_listing).target
  end
end
