# typed: strict
# frozen_string_literal: true

# Represents a point-of-interest, such as a shop, railway station, or pharmacy
class Facility < ApplicationRecord
  has_many :geocodes, as: :target, dependent: :destroy

  accepts_nested_attributes_for :geocodes
end
