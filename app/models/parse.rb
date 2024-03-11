# typed: strict
# frozen_string_literal: true

# Represents the parsing of an element within a response into a parseable model
class Parse < ApplicationRecord
  delegated_type :parseable, types: %w[Facility Listing], inverse_of: :parses
  belongs_to :response_page_element, inverse_of: :parses
  has_one :response_page, through: :response_page_element, inverse_of: :parses
  has_one :response, through: :response_page_element, inverse_of: :parses
end
