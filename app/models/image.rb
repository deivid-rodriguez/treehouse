# typed: strict
# frozen_string_literal: true

# Represents an image with a URL for a specific listing
class Image < ApplicationRecord
  belongs_to :listing, inverse_of: :images
end
