# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::StatsElem`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::StatsElem`.

class PgQuery::StatsElem
  sig { params(expr: T.nilable(PgQuery::Node), name: T.nilable(String)).void }
  def initialize(expr: nil, name: nil); end

  sig { void }
  def clear_expr; end

  sig { void }
  def clear_name; end

  sig { returns(T.nilable(PgQuery::Node)) }
  def expr; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def expr=(value); end

  sig { returns(Object) }
  def has_expr?; end

  sig { returns(String) }
  def name; end

  sig { params(value: String).void }
  def name=(value); end
end
