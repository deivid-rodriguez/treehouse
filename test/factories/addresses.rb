# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string           not null
#  city             :string
#  house            :string
#  postcode         :string
#  state            :string
#  street           :string
#  unit             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint           not null
#
# Indexes
#
#  index_addresses_on_addressable  (addressable_type,addressable_id)
#

require 'faker'

FactoryBot.define do
  factory :address do
    unit { Faker::Address.building_number if [true, false].sample }
    house { Faker::Address.building_number }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    state { %w[NSW QLD WA NT SA ACT VIC TAS].sample }
    postcode { Faker::Address.zip_code[0, 4] }

    trait :with_facility do
      addressable factory: :facility
    end

    trait :with_listing do
      addressable factory: :listing
    end
  end
end
