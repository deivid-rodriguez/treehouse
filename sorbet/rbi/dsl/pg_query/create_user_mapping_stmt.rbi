# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::CreateUserMappingStmt`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::CreateUserMappingStmt`.

class PgQuery::CreateUserMappingStmt
  sig do
    params(
      if_not_exists: T.nilable(T::Boolean),
      options: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      servername: T.nilable(String),
      user: T.nilable(PgQuery::RoleSpec)
    ).void
  end
  def initialize(if_not_exists: nil, options: T.unsafe(nil), servername: nil, user: nil); end

  sig { void }
  def clear_if_not_exists; end

  sig { void }
  def clear_options; end

  sig { void }
  def clear_servername; end

  sig { void }
  def clear_user; end

  sig { returns(Object) }
  def has_user?; end

  sig { returns(T::Boolean) }
  def if_not_exists; end

  sig { params(value: T::Boolean).void }
  def if_not_exists=(value); end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def options; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def options=(value); end

  sig { returns(String) }
  def servername; end

  sig { params(value: String).void }
  def servername=(value); end

  sig { returns(T.nilable(PgQuery::RoleSpec)) }
  def user; end

  sig { params(value: T.nilable(PgQuery::RoleSpec)).void }
  def user=(value); end
end
