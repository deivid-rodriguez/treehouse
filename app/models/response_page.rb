# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: response_pages
#
#  id               :bigint           not null, primary key
#  body             :text             not null
#  next_page        :boolean          default(FALSE), not null
#  page_number      :integer          not null
#  request_body     :text             not null
#  retrieved_at     :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  external_page_id :string           not null
#  response_id      :bigint           not null
#
# Indexes
#
#  index_response_pages_on_response_id                       (response_id)
#  index_response_pages_on_response_id_and_external_page_id  (response_id,external_page_id)
#  index_response_pages_on_response_id_and_page_number       (response_id,page_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (response_id => responses.id)
#

# Represents a single page of a response
class ResponsePage < ApplicationRecord
  extend T::Sig

  DEFAULT_PER_PAGE = 100

  attribute :retrieved_at, default: -> { Time.current }

  belongs_to :response, inverse_of: :pages
  has_many :elements, class_name: 'ResponsePageElement', inverse_of: :response_page, dependent: :destroy
  has_many :parses, through: :elements, inverse_of: :response_page
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
