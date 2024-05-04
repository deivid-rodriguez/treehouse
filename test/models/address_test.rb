# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string           not null
#  city             :string
#  house            :string
#  postcode         :string
#  state            :string
#  street           :string
#  unit             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint           not null
#
# Indexes
#
#  index_addresses_on_addressable  (addressable_type,addressable_id)
#

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  extend T::Sig

  test '#first_line without a unit' do
    assert_equal '1234 Fake St', address(unit: nil, house: '1234', street: 'Fake St').first_line
  end

  test '#first_line with a unit' do
    assert_equal '1/23 Main St', address(unit: '1', house: '23', street: 'Main St').first_line
  end

  test '#first_line missing house' do
    assert_equal 'Main St', address(unit: nil, house: nil, street: 'Main St').first_line
  end

  test '#second_line' do
    assert_equal 'Melbourne VIC 3000', address(city: 'Melbourne', state: 'VIC', postcode: '3000').second_line
  end

  test '#second_line missing parts' do
    assert_equal 'Melbourne VIC', address(city: 'Melbourne', state: 'VIC', postcode: nil).second_line
    assert_equal 'Melbourne 3000', address(city: 'Melbourne', state: nil, postcode: '3000').second_line
  end

  private

  sig { params(attrs: T::Hash[T.any(Symbol, String), T.untyped]).returns(Address) }
  def address(attrs = {})
    build(:address, attrs)
  end
end
