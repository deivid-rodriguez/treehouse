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

require 'faker'

FactoryBot.define do
  factory :listing do
    sequence(:external_id) { |n| "listing-#{n}" }

    description { Faker::Lorem.sentence }
    property_type { 'House' }
    bedroom_count { 2 }
    bathroom_count { 1 }
    carpark_count { 1 }
    price_attributes { attributes_for(:price) }

    last_seen_at { Time.current }

    trait :house do
      property_type { 'House' }
    end

    trait :apartment do
      property_type { 'Apartment' }
    end

    trait :with_address do
      address { association(:address, addressable: instance) }
    end

    trait :with_geocodes do
      geocodes { [association(:geocode, target: instance)] }
    end

    trait :with_images do
      images { [association(:image, listing: instance)] }
    end
  end
end
