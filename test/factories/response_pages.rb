# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: response_pages
#
#  id               :bigint           not null, primary key
#  body             :text             not null
#  next_page        :boolean          default(FALSE), not null
#  page_number      :integer          not null
#  request_body     :text             not null
#  retrieved_at     :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  external_page_id :string           not null
#  response_id      :bigint           not null
#
# Indexes
#
#  index_response_pages_on_response_id                       (response_id)
#  index_response_pages_on_response_id_and_external_page_id  (response_id,external_page_id)
#  index_response_pages_on_response_id_and_page_number       (response_id,page_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (response_id => responses.id)
#

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
