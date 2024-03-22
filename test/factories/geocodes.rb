# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :geocode do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    certainty { 100 }

    trait :with_facility do
      target factory: :facility
    end

    trait :with_listing do
      target factory: :listing
    end
  end
end
