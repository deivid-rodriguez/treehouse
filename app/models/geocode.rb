# typed: strict
# frozen_string_literal: true

# Represents the encoding/lookup of something's physical location into a latitude/longitude
class Geocode < ApplicationRecord
  belongs_to :target, polymorphic: true, inverse_of: :geocodes
end
