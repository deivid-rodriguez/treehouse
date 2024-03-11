# typed: strict
# frozen_string_literal: true

# Delegated types of Query include this concern
module Queryable
  extend ActiveSupport::Concern
  extend T::Sig
  extend T::Helpers
  extend T::Generic

  abstract!

  requires_ancestor { ApplicationRecord }

  included do
    T.bind(self, T.class_of(ApplicationRecord))
    has_one :query, as: :queryable, dependent: :destroy, touch: true
    accepts_nested_attributes_for :query
    delegate :name, :description, :body, :responses, to: :query
    validates :query, presence: true
  end

  sig { abstract.params(page_after: T.nilable(ResponsePage), page_size: Integer).returns(String) }
  def fetch!(page_after:, page_size:); end

  sig { abstract.returns(T.untyped) }
  def response_type; end
end
