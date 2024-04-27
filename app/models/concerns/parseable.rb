# typed: strong
# frozen_string_literal: true

# Polymorphic assocations to "ResponsePageElement" include this concern
module Parseable
  extend ActiveSupport::Concern
  extend T::Helpers

  requires_ancestor { ApplicationRecord }

  included do
    T.bind(self, T.class_of(ApplicationRecord))
    has_many :parses, as: :parseable, dependent: :destroy
    has_many :response_page_elements, -> { distinct }, through: :parses
    has_many :response_pages, -> { distinct }, through: :response_page_elements
    has_many :responses, -> { distinct }, through: :response_pages
  end
end
