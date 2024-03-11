# typed: strict
# frozen_string_literal: true

# Represents a query of some external API
class Query < ApplicationRecord
  extend T::Sig

  delegated_type :queryable, inverse_of: :query, types: %w[
    Queries::DomainQuery
    Queries::OverpassQuery
  ]

  accepts_nested_attributes_for :queryable
  delegate :fetch!, to: :queryable

  has_many :responses, dependent: :destroy, inverse_of: :query
  has_many :response_pages, through: :responses, inverse_of: :query, source: :pages

  validates :queryable, :name, :body, presence: true

  sig { returns(T.nilable(Response[T.untyped, T.untyped])) }
  def build_response
    responses.build(type: queryable.response_type) if queryable.present?
  end
end
