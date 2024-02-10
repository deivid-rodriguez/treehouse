# typed: strict
# frozen_string_literal: true

# Presentation logic for Listing model
module ListingDecorator
  extend T::Helpers
  extend T::Sig

  requires_ancestor { ActionView::Base }

  sig { returns(T.nilable(String)) }
  def price
    "#{number_to_currency monthly_rent, precision: 0} per week" if monthly_rent?
  end
end
