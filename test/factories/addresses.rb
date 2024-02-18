# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :address do
    unit { Faker::Address.building_number if [true, false].sample }
    house { Faker::Address.building_number }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    state { %w[NSW QLD WA NT SA ACT VIC TAS].sample }
    postcode { Faker::Address.zip_code[0, 4] }
  end
end
