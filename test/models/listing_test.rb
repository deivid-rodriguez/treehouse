# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: listings
#
#  id             :bigint           not null, primary key
#  available_at   :datetime
#  bathroom_count :float
#  bedroom_count  :float
#  building_area  :float
#  carpark_count  :integer
#  description    :text
#  is_new         :boolean          default(FALSE), not null
#  is_rural       :boolean          default(FALSE), not null
#  land_area      :float
#  last_seen_at   :datetime         not null
#  listed_at      :datetime
#  property_type  :text
#  slug           :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  external_id    :string           not null
#

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
