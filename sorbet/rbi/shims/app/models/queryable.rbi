# typed: strict
# frozen_string_literal: true

module Queryable
  sig { returns(String) }
  def body; end

  sig { returns(T.nilable(String)) }
  def description; end

  sig { returns(String) }
  def name; end

  sig { returns(T.untyped) }
  def responses; end
end
