# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::XmlExpr`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::XmlExpr`.

class PgQuery::XmlExpr
  sig do
    params(
      arg_names: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      args: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      indent: T.nilable(T::Boolean),
      location: T.nilable(Integer),
      name: T.nilable(String),
      named_args: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      op: T.nilable(T.any(Symbol, Integer)),
      type: T.nilable(Integer),
      typmod: T.nilable(Integer),
      xmloption: T.nilable(T.any(Symbol, Integer)),
      xpr: T.nilable(PgQuery::Node)
    ).void
  end
  def initialize(arg_names: T.unsafe(nil), args: T.unsafe(nil), indent: nil, location: nil, name: nil, named_args: T.unsafe(nil), op: nil, type: nil, typmod: nil, xmloption: nil, xpr: nil); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def arg_names; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def arg_names=(value); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def args; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def args=(value); end

  sig { void }
  def clear_arg_names; end

  sig { void }
  def clear_args; end

  sig { void }
  def clear_indent; end

  sig { void }
  def clear_location; end

  sig { void }
  def clear_name; end

  sig { void }
  def clear_named_args; end

  sig { void }
  def clear_op; end

  sig { void }
  def clear_type; end

  sig { void }
  def clear_typmod; end

  sig { void }
  def clear_xmloption; end

  sig { void }
  def clear_xpr; end

  sig { returns(Object) }
  def has_xpr?; end

  sig { returns(T::Boolean) }
  def indent; end

  sig { params(value: T::Boolean).void }
  def indent=(value); end

  sig { returns(Integer) }
  def location; end

  sig { params(value: Integer).void }
  def location=(value); end

  sig { returns(String) }
  def name; end

  sig { params(value: String).void }
  def name=(value); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def named_args; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def named_args=(value); end

  sig { returns(T.any(Symbol, Integer)) }
  def op; end

  sig { params(value: T.any(Symbol, Integer)).void }
  def op=(value); end

  sig { returns(Integer) }
  def type; end

  sig { params(value: Integer).void }
  def type=(value); end

  sig { returns(Integer) }
  def typmod; end

  sig { params(value: Integer).void }
  def typmod=(value); end

  sig { returns(T.any(Symbol, Integer)) }
  def xmloption; end

  sig { params(value: T.any(Symbol, Integer)).void }
  def xmloption=(value); end

  sig { returns(T.nilable(PgQuery::Node)) }
  def xpr; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def xpr=(value); end
end
