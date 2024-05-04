# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: facilities
#
#  id          :bigint           not null, primary key
#  name        :text
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :text             not null
#
# Indexes
#
#  index_facilities_on_external_id  (external_id) UNIQUE
#

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
