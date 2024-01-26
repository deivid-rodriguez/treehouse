# typed: strict
# frozen_string_literal: true

# Delegated types of Query include this concern
module Queryable
  extend ActiveSupport::Concern
  extend T::Helpers

  included do
    T.bind(self, T.class_of(ApplicationRecord))
    has_one :query, as: :queryable, dependent: :destroy, touch: true
    accepts_nested_attributes_for :query
    delegate :name, :description, :body, :responses, to: :query
    validates :query, presence: true
  end
end
