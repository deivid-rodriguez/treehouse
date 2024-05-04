# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id         :bigint           not null, primary key
#  index      :integer          not null
#  url        :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint           not null
#
# Indexes
#
#  index_images_on_listing_id  (listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  extend T::Sig

  test '#listing exists' do
    assert_not_nil create(:image).listing
  end
end
