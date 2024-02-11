# typed: strict
# frozen_string_literal: true

# Concern for calculating address fields into a single address string
module CalculatesAddress
  extend ActiveSupport::Concern
  extend T::Generic
  extend T::Sig

  abstract!

  sig { abstract.returns(T.nilable(String)) }
  def address_unit; end

  sig { abstract.returns(T.nilable(String)) }
  def address_house; end

  sig { abstract.returns(T.nilable(String)) }
  def address_street; end

  sig { abstract.returns(T.nilable(String)) }
  def address_city; end

  sig { abstract.returns(T.nilable(String)) }
  def address_state; end

  sig { abstract.returns(T.nilable(String)) }
  def address_postcode; end

  sig { returns(String) }
  def calculated_address
    [
      calculated_address_line1,
      (", #{address_city}" if address_city.present?),
      (" #{address_state}" if address_state.present?),
      (" #{address_postcode}" if address_postcode.present?),
    ].compact.join
  end

  sig { returns(String) }
  def calculated_address_line1
    [
      ("#{address_unit}/" if address_unit.present?),
      ("#{address_house} " if address_house.present?),
      address_street.presence,
    ].compact.join
  end
end
