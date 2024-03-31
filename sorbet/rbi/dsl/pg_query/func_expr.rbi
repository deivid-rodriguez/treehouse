# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::FuncExpr`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::FuncExpr`.

class PgQuery::FuncExpr
  sig do
    params(
      args: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      funccollid: T.nilable(Integer),
      funcformat: T.nilable(T.any(Symbol, Integer)),
      funcid: T.nilable(Integer),
      funcresulttype: T.nilable(Integer),
      funcretset: T.nilable(T::Boolean),
      funcvariadic: T.nilable(T::Boolean),
      inputcollid: T.nilable(Integer),
      location: T.nilable(Integer),
      xpr: T.nilable(PgQuery::Node)
    ).void
  end
  def initialize(args: T.unsafe(nil), funccollid: nil, funcformat: nil, funcid: nil, funcresulttype: nil, funcretset: nil, funcvariadic: nil, inputcollid: nil, location: nil, xpr: nil); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def args; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def args=(value); end

  sig { void }
  def clear_args; end

  sig { void }
  def clear_funccollid; end

  sig { void }
  def clear_funcformat; end

  sig { void }
  def clear_funcid; end

  sig { void }
  def clear_funcresulttype; end

  sig { void }
  def clear_funcretset; end

  sig { void }
  def clear_funcvariadic; end

  sig { void }
  def clear_inputcollid; end

  sig { void }
  def clear_location; end

  sig { void }
  def clear_xpr; end

  sig { returns(Integer) }
  def funccollid; end

  sig { params(value: Integer).void }
  def funccollid=(value); end

  sig { returns(T.any(Symbol, Integer)) }
  def funcformat; end

  sig { params(value: T.any(Symbol, Integer)).void }
  def funcformat=(value); end

  sig { returns(Integer) }
  def funcid; end

  sig { params(value: Integer).void }
  def funcid=(value); end

  sig { returns(Integer) }
  def funcresulttype; end

  sig { params(value: Integer).void }
  def funcresulttype=(value); end

  sig { returns(T::Boolean) }
  def funcretset; end

  sig { params(value: T::Boolean).void }
  def funcretset=(value); end

  sig { returns(T::Boolean) }
  def funcvariadic; end

  sig { params(value: T::Boolean).void }
  def funcvariadic=(value); end

  sig { returns(Object) }
  def has_xpr?; end

  sig { returns(Integer) }
  def inputcollid; end

  sig { params(value: Integer).void }
  def inputcollid=(value); end

  sig { returns(Integer) }
  def location; end

  sig { params(value: Integer).void }
  def location=(value); end

  sig { returns(T.nilable(PgQuery::Node)) }
  def xpr; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def xpr=(value); end
end
