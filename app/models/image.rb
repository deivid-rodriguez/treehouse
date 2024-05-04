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

# Represents an image with a URL for a specific listing
class Image < ApplicationRecord
  include Admin::Image

  belongs_to :listing, inverse_of: :images
end
