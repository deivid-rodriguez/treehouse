# typed: strict
# frozen_string_literal: true

# Represents a query of some external API
class Query < ApplicationRecord
  delegated_type :queryable, types: %w[Queries::OverpassQuery]
  accepts_nested_attributes_for :queryable
  delegate :fetch!, to: :queryable

  has_many :responses, dependent: :destroy, inverse_of: :query

  validates :queryable, :name, :body, presence: true
end
