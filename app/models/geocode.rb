# typed: strict
# frozen_string_literal: true

# Represents the encoding/lookup of something's physical location into a latitude/longitude
class Geocode < ApplicationRecord
  include Admin::Geocode

  belongs_to :target, polymorphic: true, inverse_of: :geocodes
  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address
end
