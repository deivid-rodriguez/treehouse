# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::BoolExpr`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::BoolExpr`.

class PgQuery::BoolExpr
  sig do
    params(
      args: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      boolop: T.nilable(T.any(Symbol, Integer)),
      location: T.nilable(Integer),
      xpr: T.nilable(PgQuery::Node)
    ).void
  end
  def initialize(args: T.unsafe(nil), boolop: nil, location: nil, xpr: nil); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def args; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def args=(value); end

  sig { returns(T.any(Symbol, Integer)) }
  def boolop; end

  sig { params(value: T.any(Symbol, Integer)).void }
  def boolop=(value); end

  sig { void }
  def clear_args; end

  sig { void }
  def clear_boolop; end

  sig { void }
  def clear_location; end

  sig { void }
  def clear_xpr; end

  sig { returns(Object) }
  def has_xpr?; end

  sig { returns(Integer) }
  def location; end

  sig { params(value: Integer).void }
  def location=(value); end

  sig { returns(T.nilable(PgQuery::Node)) }
  def xpr; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def xpr=(value); end
end
