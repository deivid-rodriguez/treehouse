# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :response_page do
    body { Faker::Lorem.paragraph }
    sequence(:page_number)

    trait :first do
      page_number { 1 }
    end

    trait :domain do
      response factory: %i[response domain]
    end

    trait :overpass do
      response factory: %i[response overpass]
    end
  end
end
