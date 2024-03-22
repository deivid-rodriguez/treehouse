# typed: strict
# frozen_string_literal: true

require 'test_helper'

class FacilityTest < ActiveSupport::TestCase
  extend T::Sig

  test 'with address' do
    assert_not_nil create(:facility, :with_address).address
  end

  test 'with geocodes' do
    assert_not_empty create(:facility, :with_geocodes).geocodes
  end
end
