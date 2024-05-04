# typed: strict
# frozen_string_literal: true

# An unknown type of price
class NullPrice < Price
  extend T::Sig

  sig { returns(T::Boolean) }
  def null? = true
end
