# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :image do
    listing
    sequence(:index)
    url { Faker::LoremFlickr.image(size: '400x300') }
  end
end
