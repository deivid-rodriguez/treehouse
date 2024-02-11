# typed: strict
# frozen_string_literal: true

# Presentation logic for Address model
module AddressDecorator
  extend T::Helpers
  extend T::Sig

  requires_ancestor { ActionView::Helpers }
  requires_ancestor { Address }

  sig { returns(T.nilable(String)) }
  def to_s
    oneline
  end
end
