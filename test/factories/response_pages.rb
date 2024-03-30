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
      response factory: :domain_response
      transient do
        body_fixture { file_fixture("http/responses/domain_response/#{body_fixture_type}.json") }
      end
    end

    trait :overpass do
      response factory: :overpass_response
      transient do
        body_fixture { file_fixture("http/responses/overpass_response/#{body_fixture_type}.xml") }
      end
    end

    trait :fetched do
      transient do
        body_fixture_type { 'empty' }
      end

      body { body_fixture.read }
    end
  end
end
