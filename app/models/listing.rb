# typed: strict
# frozen_string_literal: true

# Represents a property listed for rent or sale
class Listing < ApplicationRecord
  has_many :geocodes, as: :target, dependent: :destroy
  has_many :images, dependent: :destroy, inverse_of: :listing

  accepts_nested_attributes_for :geocodes, :images
end