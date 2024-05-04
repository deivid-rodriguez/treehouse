# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: parses
#
#  id                       :bigint           not null, primary key
#  parseable_type           :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  parseable_id             :bigint           not null
#  response_page_element_id :bigint           not null
#
# Indexes
#
#  index_parses_on_parseable                 (parseable_type,parseable_id)
#  index_parses_on_response_page_element_id  (response_page_element_id)
#
# Foreign Keys
#
#  fk_rails_...  (response_page_element_id => response_page_elements.id)
#

# Represents the parsing of an element within a response into a parseable model
class Parse < ApplicationRecord
  include Admin::Parse

  delegated_type :parseable, types: %w[Facility Listing], inverse_of: :parses, autosave: true
  belongs_to :response_page_element, inverse_of: :parses
  has_one :response_page, through: :response_page_element, inverse_of: :parses
  has_one :response, through: :response_page_element, inverse_of: :parses
end
