# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::AlterRoleSetStmt`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::AlterRoleSetStmt`.

class PgQuery::AlterRoleSetStmt
  sig do
    params(
      database: T.nilable(String),
      role: T.nilable(PgQuery::RoleSpec),
      setstmt: T.nilable(PgQuery::VariableSetStmt)
    ).void
  end
  def initialize(database: nil, role: nil, setstmt: nil); end

  sig { void }
  def clear_database; end

  sig { void }
  def clear_role; end

  sig { void }
  def clear_setstmt; end

  sig { returns(String) }
  def database; end

  sig { params(value: String).void }
  def database=(value); end

  sig { returns(T.nilable(PgQuery::RoleSpec)) }
  def role; end

  sig { params(value: T.nilable(PgQuery::RoleSpec)).void }
  def role=(value); end

  sig { returns(T.nilable(PgQuery::VariableSetStmt)) }
  def setstmt; end

  sig { params(value: T.nilable(PgQuery::VariableSetStmt)).void }
  def setstmt=(value); end
end