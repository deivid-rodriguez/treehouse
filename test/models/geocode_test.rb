# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: geocodes
#
#  id          :bigint           not null, primary key
#  certainty   :integer
#  latitude    :float            not null
#  longitude   :float            not null
#  target_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  target_id   :bigint           not null
#
# Indexes
#
#  index_geocodes_on_target  (target_type,target_id)
#

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
