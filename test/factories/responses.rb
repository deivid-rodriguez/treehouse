# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :response do
    trait :domain do
      type { Responses::DomainResponse }
      transient do
        query_type { :domain }
      end
    end

    trait :overpass do
      type { Responses::OverpassResponse }
      transient do
        query_type { :overpass }
      end
    end

    query { association(:query, query_type) }

    trait :fetched do
      request_body { query.body }
      body { Faker::Lorem.paragraph }
      retrieved_at { Time.current }
    end

    transient do
      # Fallback value for query_type -- raises if neither trait is specified
      query_type { raise 'response factory requires one of the following traits: domain, overpass' }
    end
  end
end
