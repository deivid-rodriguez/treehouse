# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id         :bigint           not null, primary key
#  type       :string           default("Response"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  query_id   :bigint           not null
#
# Indexes
#
#  index_responses_on_query_id  (query_id)
#
# Foreign Keys
#
#  fk_rails_...  (query_id => queries.id)
#

# Represents the response fetched for a query at some point in time
class Response < ApplicationRecord
  extend T::Generic
  extend T::Sig
  include Admin::Response

  TYPES = T.let(
    %w[
      Responses::DomainResponse
      Responses::OverpassResponse
      Responses::RealEstateResponse
    ].freeze,
    T::Array[String],
  )

  Element = type_member
  Model = type_member { { upper: ApplicationRecord } }

  belongs_to :query, inverse_of: :responses
  has_many :pages, class_name: 'ResponsePage', inverse_of: :response, dependent: :destroy
  has_many :elements, -> { distinct }, class_name: 'ResponsePageElement', through: :pages, inverse_of: :response
  has_many :parses, through: :elements, inverse_of: :response

  accepts_nested_attributes_for :pages

  sig { params(page_after: T.nilable(ResponsePage), page_size: Integer).returns(T.nilable(ResponsePage)) }
  def fetch!(page_after: nil, page_size: ResponsePage::DEFAULT_PER_PAGE)
    query&.fetch!(page_after:, page_size:).tap do |page|
      pages << page
    end
  end

  sig { params(page: ResponsePage).returns(T::Enumerable[Parse]) }
  def parse!(page)
    raise NotImplementedError, 'Response base class does not implement #parse!'
  end
end
