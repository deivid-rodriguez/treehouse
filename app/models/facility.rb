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

# Represents a point-of-interest, such as a shop, railway station, or pharmacy
class Facility < ApplicationRecord
  include Parseable

  has_one :address, as: :addressable, dependent: :destroy
  has_many :geocodes, as: :target, dependent: :destroy

  accepts_nested_attributes_for :address, :geocodes
end
