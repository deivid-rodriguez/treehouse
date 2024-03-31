# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::MergeStmt`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::MergeStmt`.

class PgQuery::MergeStmt
  sig do
    params(
      join_condition: T.nilable(PgQuery::Node),
      merge_when_clauses: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      relation: T.nilable(PgQuery::RangeVar),
      source_relation: T.nilable(PgQuery::Node),
      with_clause: T.nilable(PgQuery::WithClause)
    ).void
  end
  def initialize(join_condition: nil, merge_when_clauses: T.unsafe(nil), relation: nil, source_relation: nil, with_clause: nil); end

  sig { void }
  def clear_join_condition; end

  sig { void }
  def clear_merge_when_clauses; end

  sig { void }
  def clear_relation; end

  sig { void }
  def clear_source_relation; end

  sig { void }
  def clear_with_clause; end

  sig { returns(Object) }
  def has_join_condition?; end

  sig { returns(Object) }
  def has_relation?; end

  sig { returns(Object) }
  def has_source_relation?; end

  sig { returns(Object) }
  def has_with_clause?; end

  sig { returns(T.nilable(PgQuery::Node)) }
  def join_condition; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def join_condition=(value); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def merge_when_clauses; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def merge_when_clauses=(value); end

  sig { returns(T.nilable(PgQuery::RangeVar)) }
  def relation; end

  sig { params(value: T.nilable(PgQuery::RangeVar)).void }
  def relation=(value); end

  sig { returns(T.nilable(PgQuery::Node)) }
  def source_relation; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def source_relation=(value); end

  sig { returns(T.nilable(PgQuery::WithClause)) }
  def with_clause; end

  sig { params(value: T.nilable(PgQuery::WithClause)).void }
  def with_clause=(value); end
end
