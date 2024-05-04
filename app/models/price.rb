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

# Represents an image with a URL for a specific listing
class Price < ApplicationRecord
  extend T::Sig

  belongs_to :listing, inverse_of: :price

  validates :type, presence: true

  sig { returns(T::Boolean) }
  def buy? = false

  sig { returns(T::Boolean) }
  def rent? = false

  sig { returns(T::Boolean) }
  def null? = false

  sig { returns(String) }
  def to_partial_path = 'prices/price'
end
