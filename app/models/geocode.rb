# frozen_string_literal: true

# Represents the encoding/lookup of something's physical location into a latitude/longitude
class Geocode < ApplicationRecord
  has_many :facility_geocodes, dependent: :destroy, inverse_of: :geocode
  has_many :facilities, through: :facility_geocodes, inverse_of: :geocodes
end
