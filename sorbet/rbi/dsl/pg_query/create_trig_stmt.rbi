# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::CreateTrigStmt`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::CreateTrigStmt`.

class PgQuery::CreateTrigStmt
  sig do
    params(
      args: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      columns: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      constrrel: T.nilable(PgQuery::RangeVar),
      deferrable: T.nilable(T::Boolean),
      events: T.nilable(Integer),
      funcname: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      initdeferred: T.nilable(T::Boolean),
      isconstraint: T.nilable(T::Boolean),
      relation: T.nilable(PgQuery::RangeVar),
      replace: T.nilable(T::Boolean),
      row: T.nilable(T::Boolean),
      timing: T.nilable(Integer),
      transition_rels: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      trigname: T.nilable(String),
      when_clause: T.nilable(PgQuery::Node)
    ).void
  end
  def initialize(args: T.unsafe(nil), columns: T.unsafe(nil), constrrel: nil, deferrable: nil, events: nil, funcname: T.unsafe(nil), initdeferred: nil, isconstraint: nil, relation: nil, replace: nil, row: nil, timing: nil, transition_rels: T.unsafe(nil), trigname: nil, when_clause: nil); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def args; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def args=(value); end

  sig { void }
  def clear_args; end

  sig { void }
  def clear_columns; end

  sig { void }
  def clear_constrrel; end

  sig { void }
  def clear_deferrable; end

  sig { void }
  def clear_events; end

  sig { void }
  def clear_funcname; end

  sig { void }
  def clear_initdeferred; end

  sig { void }
  def clear_isconstraint; end

  sig { void }
  def clear_relation; end

  sig { void }
  def clear_replace; end

  sig { void }
  def clear_row; end

  sig { void }
  def clear_timing; end

  sig { void }
  def clear_transition_rels; end

  sig { void }
  def clear_trigname; end

  sig { void }
  def clear_when_clause; end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def columns; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def columns=(value); end

  sig { returns(T.nilable(PgQuery::RangeVar)) }
  def constrrel; end

  sig { params(value: T.nilable(PgQuery::RangeVar)).void }
  def constrrel=(value); end

  sig { returns(T::Boolean) }
  def deferrable; end

  sig { params(value: T::Boolean).void }
  def deferrable=(value); end

  sig { returns(Integer) }
  def events; end

  sig { params(value: Integer).void }
  def events=(value); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def funcname; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def funcname=(value); end

  sig { returns(Object) }
  def has_constrrel?; end

  sig { returns(Object) }
  def has_relation?; end

  sig { returns(Object) }
  def has_when_clause?; end

  sig { returns(T::Boolean) }
  def initdeferred; end

  sig { params(value: T::Boolean).void }
  def initdeferred=(value); end

  sig { returns(T::Boolean) }
  def isconstraint; end

  sig { params(value: T::Boolean).void }
  def isconstraint=(value); end

  sig { returns(T.nilable(PgQuery::RangeVar)) }
  def relation; end

  sig { params(value: T.nilable(PgQuery::RangeVar)).void }
  def relation=(value); end

  sig { returns(T::Boolean) }
  def replace; end

  sig { params(value: T::Boolean).void }
  def replace=(value); end

  sig { returns(T::Boolean) }
  def row; end

  sig { params(value: T::Boolean).void }
  def row=(value); end

  sig { returns(Integer) }
  def timing; end

  sig { params(value: Integer).void }
  def timing=(value); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def transition_rels; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def transition_rels=(value); end

  sig { returns(String) }
  def trigname; end

  sig { params(value: String).void }
  def trigname=(value); end

  sig { returns(T.nilable(PgQuery::Node)) }
  def when_clause; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def when_clause=(value); end
end
