# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: queries
#
#  id             :bigint           not null, primary key
#  body           :text             not null
#  description    :text
#  name           :text             not null
#  queryable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  queryable_id   :string           not null
#
# Indexes
#
#  index_queries_on_queryable_type_and_queryable_id  (queryable_type,queryable_id) UNIQUE
#

# Represents a query of some external API
class Query < ApplicationRecord
  extend T::Sig
  include Admin::Query

  delegated_type :queryable, inverse_of: :query, types: Queryable::TYPES

  accepts_nested_attributes_for :queryable
  delegate :fetch!, to: :queryable

  has_many :responses, dependent: :destroy, inverse_of: :query
  has_many :response_pages, -> { distinct }, through: :responses, inverse_of: :query, source: :pages

  validates :queryable, :name, :body, presence: true

  before_validation do
    self.queryable ||= queryable_class.new if queryable_type.present?
  end

  sig { returns(T.nilable(Response[T.untyped, T.untyped])) }
  def build_response
    responses.build(type: queryable.response_type) if queryable.present?
  end
end
