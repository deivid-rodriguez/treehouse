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

# Represents the encoding/lookup of something's physical location into a latitude/longitude
class Geocode < ApplicationRecord
  extend T::Sig
  include Admin::Geocode

  belongs_to :target, polymorphic: true, inverse_of: :geocodes
  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address

  sig { returns([Numeric, Numeric]) }
  def coordinates
    [latitude, longitude]
  end
end
