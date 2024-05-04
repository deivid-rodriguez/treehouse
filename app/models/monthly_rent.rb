# typed: strict
# frozen_string_literal: true

# A type of price representing the monthly rent for a listing
class MonthlyRent < Price
  extend T::Sig

  sig { override.returns(T::Boolean) }
  def rent? = true

  # "#{number_to_currency monthly_rent, precision: 0}/wk" if monthly_rent?
end
