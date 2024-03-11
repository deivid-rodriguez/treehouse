# typed: strict
# frozen_string_literal: true

# Represents a single page of a response
class ResponsePage < ApplicationRecord
  extend T::Sig

  DEFAULT_PER_PAGE = 100

  attribute :retrieved_at, default: -> { Time.zone.now }

  belongs_to :response, inverse_of: :pages
  has_many :elements, class_name: 'ResponsePageElement', inverse_of: :response_page, dependent: :destroy
  has_many :parses, through: :elements, inverse_of: :response_pages
  has_one :query, through: :response, inverse_of: :response_pages

  accepts_nested_attributes_for :elements

  # Default value for request_body should be the query.body at the time of the query
  before_validation { self.request_body = query.try(:body) if request_body.blank? }

  # External ID should default to just the page number if not overridden
  before_validation { self.external_page_id = page_number.to_s if external_page_id.blank? }

  validates :body, :external_page_id, :request_body, :retrieved_at, presence: true
  validates :page_number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  sig { returns(T.nilable(ResponsePage)) }
  def fetch_next_page!
    return unless next_page?

    response&.fetch!(page_after: self)
  end

  sig { returns(T::Enumerable[Parse]) }
  def parse!
    response&.parse!(self) || []
  end
end
