# typed: strict
# frozen_string_literal: true

# Represents the address of a Facility or Location
class Address < ApplicationRecord
  extend T::Sig

  belongs_to :addressable, polymorphic: true, inverse_of: :address

  sig { returns(String) }
  def oneline
    lines.join(', ')
  end

  sig { returns(T::Array[String]) }
  def lines
    [first_line, second_line].compact
  end

  sig { returns(T.nilable(String)) }
  def first_line
    [
      ("#{unit}/" if unit.present?),
      ("#{house} " if house.present?),
      street.presence,
    ].compact.join.strip.presence
  end

  sig { returns(T.nilable(String)) }
  def second_line
    [city, state, postcode].map(&:presence).compact.join(' ').strip.presence
  end
end
