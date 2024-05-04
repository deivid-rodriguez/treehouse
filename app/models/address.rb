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

# Represents the address of a Facility or Location
class Address < ApplicationRecord
  include Admin::Address
  extend T::Sig

  belongs_to :addressable, polymorphic: true, inverse_of: :address

  sig { returns(String) }
  def oneline
    lines.join(', ')
  end

  sig { returns(T::Array[String]) }
  def lines
    [first_line, second_line].compact
  end

  sig { returns(T.nilable(String)) }
  def first_line
    [
      ("#{unit}/" if unit.present?),
      ("#{house} " if house.present?),
      street.presence,
    ].compact.join.strip.presence
  end

  sig { returns(T.nilable(String)) }
  def second_line
    [city, state, postcode].map(&:presence).compact.join(' ').strip.presence
  end
end
