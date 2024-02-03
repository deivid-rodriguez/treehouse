# typed: strict
# frozen_string_literal: true

# Represents a point-of-interest, such as a shop, railway station, or pharmacy
class Facility < ApplicationRecord
  has_many :facility_geocodes, dependent: :destroy, inverse_of: :facility
  has_many :geocodes, through: :facility_geocodes, inverse_of: :facilities

  accepts_nested_attributes_for :geocodes
end
