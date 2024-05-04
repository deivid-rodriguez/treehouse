# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: response_page_elements
#
#  id               :bigint           not null, primary key
#  index            :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  external_id      :string
#  response_page_id :bigint           not null
#
# Indexes
#
#  index_response_page_elements_on_response_page_id            (response_page_id)
#  index_response_page_elements_on_response_page_id_and_index  (response_page_id,index) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (response_page_id => response_pages.id)
#

# Represents a single element within a single page of a response
class ResponsePageElement < ApplicationRecord
  belongs_to :response_page, inverse_of: :elements
  has_one :response, through: :response_page, inverse_of: :elements
  has_one :query, through: :response, inverse_of: :response_pages

  has_many :parses, inverse_of: :response_page_element, dependent: :destroy
  accepts_nested_attributes_for :parses

  validates :index, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
