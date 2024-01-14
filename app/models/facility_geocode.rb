# frozen_string_literal: true

# Represents the geocoding of a specific facility
class FacilityGeocode < ApplicationRecord
  belongs_to :facility, inverse_of: :facility_geocodes
  belongs_to :geocode, inverse_of: :facility_geocodes
end
