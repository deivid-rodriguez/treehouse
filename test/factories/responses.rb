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

require 'faker'

FactoryBot.define do
  factory :response do
    factory :domain_response, class: 'Responses::DomainResponse' do
      query factory: %i[query domain]
    end

    factory :real_estate_response, class: 'Responses::RealEstateResponse' do
      query factory: %i[query real_estate]
    end

    factory :overpass_response, class: 'Responses::OverpassResponse' do
      query factory: %i[query overpass]
    end
  end
end
