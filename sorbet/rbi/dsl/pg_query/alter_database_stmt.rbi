# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::AlterDatabaseStmt`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::AlterDatabaseStmt`.

class PgQuery::AlterDatabaseStmt
  sig do
    params(
      dbname: T.nilable(String),
      options: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node]))
    ).void
  end
  def initialize(dbname: nil, options: T.unsafe(nil)); end

  sig { void }
  def clear_dbname; end

  sig { void }
  def clear_options; end

  sig { returns(String) }
  def dbname; end

  sig { params(value: String).void }
  def dbname=(value); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def options; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def options=(value); end
end