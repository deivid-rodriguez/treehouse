# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :response do
    factory :domain_response, class: 'Responses::DomainResponse' do
      query factory: %i[query domain]
    end

    factory :real_estate_response, class: 'Responses::RealEstateResponse' do
      query factory: %i[query real_estate]
    end

    factory :overpass_response, class: 'Responses::OverpassResponse' do
      query factory: %i[query overpass]
    end
  end
end
