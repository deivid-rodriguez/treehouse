# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: geocodes
#
#  id          :bigint           not null, primary key
#  certainty   :integer
#  latitude    :float            not null
#  longitude   :float            not null
#  target_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  target_id   :bigint           not null
#
# Indexes
#
#  index_geocodes_on_target  (target_type,target_id)
#

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
