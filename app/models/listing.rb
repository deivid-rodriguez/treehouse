# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: listings
#
#  id             :bigint           not null, primary key
#  available_at   :datetime
#  bathroom_count :float
#  bedroom_count  :float
#  building_area  :float
#  carpark_count  :integer
#  description    :text
#  is_new         :boolean          default(FALSE), not null
#  is_rural       :boolean          default(FALSE), not null
#  land_area      :float
#  last_seen_at   :datetime         not null
#  listed_at      :datetime
#  property_type  :text
#  slug           :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  external_id    :string           not null
#

# Represents a property listed for rent or sale
class Listing < ApplicationRecord
  extend T::Sig
  include Admin::Listing
  include Parseable

  has_one :address, as: :addressable, dependent: :destroy
  has_many :geocodes, as: :target, dependent: :destroy
  has_many :images, dependent: :destroy, inverse_of: :listing
  has_one :price, dependent: :destroy, inverse_of: :listing

  accepts_nested_attributes_for :address, :geocodes, :images, :price, update_only: true

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
