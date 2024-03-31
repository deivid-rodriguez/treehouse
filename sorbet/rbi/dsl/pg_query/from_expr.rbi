# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::FromExpr`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::FromExpr`.

class PgQuery::FromExpr
  sig do
    params(
      fromlist: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      quals: T.nilable(PgQuery::Node)
    ).void
  end
  def initialize(fromlist: T.unsafe(nil), quals: nil); end

  sig { void }
  def clear_fromlist; end

  sig { void }
  def clear_quals; end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def fromlist; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def fromlist=(value); end

  sig { returns(Object) }
  def has_quals?; end

  sig { returns(T.nilable(PgQuery::Node)) }
  def quals; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def quals=(value); end
end
