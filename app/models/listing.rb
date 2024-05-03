# typed: strict
# frozen_string_literal: true

# Represents a property listed for rent or sale
class Listing < ApplicationRecord
  extend T::Sig
  include Admin::Listing
  include Parseable

  has_one :address, as: :addressable, dependent: :destroy
  has_many :geocodes, as: :target, dependent: :destroy
  has_many :images, dependent: :destroy, inverse_of: :listing

  accepts_nested_attributes_for :address, :geocodes, :images, update_only: true

  sig { params(value: T.untyped).void }
  def images_attributes=(value)
    Array(value).each do |attributes|
      existing_image = images.find { _1.url == attributes.fetch(:url) }
      existing_image.present? ? existing_image.assign_attributes(attributes) : images.build(attributes)
    end
  end

  sig { params(value: T.untyped).void }
  def geocodes_attributes=(value)
    Array(value).each do |attributes|
      existing = geocodes.map(&:coordinates)
      geocodes.build(attributes) unless existing.any?(attributes.values_at(:latitude, :longitude))
    end
  end
end
