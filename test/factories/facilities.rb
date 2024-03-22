# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :facility do
    name { Faker::Lorem.sentence }

    sequence(:external_id) { |n| "external_id_#{n.hash}" }

    trait :with_address do
      address { association(:address, addressable: instance) }
    end

    trait :with_geocodes do
      geocodes { [association(:geocode, target: instance)] }
    end
  end
end
