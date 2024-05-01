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

    trait :real_estate do
      response factory: :real_estate_response
      transient do
        body_fixture { file_fixture("http/responses/real_estate_response/#{body_fixture_type}.html") }
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
      request_body { Faker::Lorem.paragraph }
    end

    trait :complete do
      transient do
        body_fixture_type { 'complete' }
      end
    end

    trait :single do
      transient do
        body_fixture_type { 'single' }
      end
    end
  end
end
