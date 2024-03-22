# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :listing do
    sequence(:external_id) { |n| "listing-#{n}" }

    description { Faker::Lorem.sentence }
    property_type { 'House' }
    bedroom_count { 2 }
    bathroom_count { 1 }
    carpark_count { 1 }
    monthly_rent { 400 }

    last_seen_at { Time.zone.now }

    trait :house do
      property_type { 'House' }
    end

    trait :apartment do
      property_type { 'Apartment' }
    end

    trait :with_address do
      address
    end

    trait :with_geocodes do
      geocodes
    end

    trait :with_images do
      images
    end

    trait :with_all_associations do
      address
      geocodes
      images
    end
  end
end
