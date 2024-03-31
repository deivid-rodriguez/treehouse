# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::ReassignOwnedStmt`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::ReassignOwnedStmt`.

class PgQuery::ReassignOwnedStmt
  sig do
    params(
      newrole: T.nilable(PgQuery::RoleSpec),
      roles: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node]))
    ).void
  end
  def initialize(newrole: nil, roles: T.unsafe(nil)); end

  sig { void }
  def clear_newrole; end

  sig { void }
  def clear_roles; end

  sig { returns(Object) }
  def has_newrole?; end

  sig { returns(T.nilable(PgQuery::RoleSpec)) }
  def newrole; end

  sig { params(value: T.nilable(PgQuery::RoleSpec)).void }
  def newrole=(value); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def roles; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def roles=(value); end
end
