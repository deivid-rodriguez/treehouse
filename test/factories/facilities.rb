# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: facilities
#
#  id          :bigint           not null, primary key
#  name        :text
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :text             not null
#
# Indexes
#
#  index_facilities_on_external_id  (external_id) UNIQUE
#

require 'faker'

FactoryBot.define do
  factory :facility do
    name { Faker::Lorem.sentence }

    sequence(:external_id) { |n| "external_id_#{n.hash}" }

    trait :with_address do
      address { association(:address, addressable: instance) }
    end

    trait :with_geocodes do
      geocodes { [association(:geocode, target: instance)] }
    end
  end
end
