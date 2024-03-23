# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :response do
    trait :domain do
      type { Responses::DomainResponse }
      query factory: %i[query domain]
    end

    trait :overpass do
      type { Responses::OverpassResponse }
      query factory: %i[query overpass]
    end

    trait :fetched do
      request_body { query.body }
      body { Faker::Lorem.paragraph }
      retrieved_at { Time.current }
    end
  end
end
