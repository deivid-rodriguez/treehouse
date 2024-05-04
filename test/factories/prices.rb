# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: prices
#
#  id         :bigint           not null, primary key
#  display    :string
#  max        :decimal(, )
#  min        :decimal(, )
#  type       :string           not null
#  value      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint           not null
#
# Indexes
#
#  index_prices_on_listing_id  (listing_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#

require 'faker'

FactoryBot.define do
  factory :price do
    value { 420 }
    type { MonthlyRent }
  end
end
