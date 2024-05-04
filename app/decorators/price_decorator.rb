# typed: strict
# frozen_string_literal: true

# Presentation logic for Address model
module PriceDecorator
  extend T::Helpers
  extend T::Sig

  requires_ancestor { ActionView::Helpers }
  requires_ancestor { Price }

  sig { returns(T.nilable(String)) }
  def formatted
    return format_value if value_or_parse.present?
    return format_min_max if min.present? && max.present?
    return format_min if min.present?
    return format_max if max.present?

    display
  end

  alias to_s formatted

  sig { returns(T.nilable(String)) }
  def format_value
    number_to_currency value_or_parse, precision: 0
  end

  sig { returns(String) }
  def format_min_max
    [min, max].map { |number| number_to_currency(number, precision: 0) }.join(' - ')
  end

  sig { returns(String) }
  def format_min
    "From #{number_to_currency min, precision: 0}"
  end

  sig { returns(String) }
  def format_max
    "Under #{number_to_currency max, precision: 0}"
  end

  sig { returns(T.nilable(Numeric)) }
  def parse_display
    Integer(display&.gsub(/\D/, ''))
  rescue TypeError, ArgumentError
    nil
  end

  sig { returns(T.nilable(Numeric)) }
  def value_or_parse
    value.presence || parse_display
  end
end
