# typed: strict
# frozen_string_literal: true

# Presentation logic for Listing model
module ListingDecorator
  extend T::Helpers
  extend T::Sig

  requires_ancestor { ActionView::Helpers }
  requires_ancestor { Listing }

  sig { returns(T.nilable(String)) }
  def description
    super
      &.gsub(%r{<br\s*/?>}, "\n")
      &.gsub(%r{</?b>}, '')
  end

  sig { returns(T::Boolean) }
  def image?
    images.any?
  end

  sig { returns(T.nilable(String)) }
  def image_url
    images.first&.url
  end

  sig { returns(Price) }
  def price
    super || NullPrice.new
  end
end
