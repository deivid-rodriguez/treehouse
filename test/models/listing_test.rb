# typed: strict
# frozen_string_literal: true

require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  extend T::Sig

  test 'with address' do
    assert_not_nil create(:listing, :with_address).address
  end

  test 'with geocodes' do
    assert_not_empty create(:listing, :with_geocodes).geocodes
  end

  test 'with images' do
    assert_not_empty create(:listing, :with_images).images
  end
end
