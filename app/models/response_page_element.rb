# typed: strict
# frozen_string_literal: true

# Represents a single element within a single page of a response
class ResponsePageElement < ApplicationRecord
  belongs_to :response_page, inverse_of: :elements
  has_one :response, through: :response_page, inverse_of: :elements
  has_one :query, through: :response, inverse_of: :response_pages

  has_many :parses, inverse_of: :response_page_element, dependent: :destroy
  accepts_nested_attributes_for :parses

  validates :index, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
