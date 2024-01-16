# frozen_string_literal: true

# Delegated types of Query include this concern
module Queryable
  extend ActiveSupport::Concern

  included do
    has_one :query, as: :queryable, dependent: :destroy, touch: true
    accepts_nested_attributes_for :query
    delegate :name, :description, :body, :responses, to: :query
    validates :query, presence: true
  end
end
