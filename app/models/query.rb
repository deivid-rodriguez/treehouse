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

  before_validation do
    self.queryable ||= queryable_class.new if queryable_type.present?
  end

  sig { returns(T.nilable(Response[T.untyped, T.untyped])) }
  def build_response
    responses.build(type: queryable.response_type) if queryable.present?
  end

  rails_admin do
    configure(:queryable) do
      pretty_value { value.class.name.demodulize }
    end

    exclude_fields :responses, :response_pages
  end
end
