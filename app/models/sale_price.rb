# typed: strict
# frozen_string_literal: true

# A type of price representing the cost to buy a listing
class SalePrice < Price
  extend T::Sig

  sig { override.returns(T::Boolean) }
  def buy? = true
end
