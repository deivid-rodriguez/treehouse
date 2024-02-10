# typed: strict
# frozen_string_literal: true

# Presentation logic for Listing model
module ListingDecorator
  extend T::Helpers
  extend T::Sig

  requires_ancestor { ActionView::Base }

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
    images.first.url if image?
  end

  sig { returns(T.nilable(String)) }
  def price
    "#{number_to_currency monthly_rent, precision: 0} per week" if monthly_rent?
  end
end
