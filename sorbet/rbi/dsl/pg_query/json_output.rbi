# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::JsonOutput`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::JsonOutput`.

class PgQuery::JsonOutput
  sig { params(returning: T.nilable(PgQuery::JsonReturning), type_name: T.nilable(PgQuery::TypeName)).void }
  def initialize(returning: nil, type_name: nil); end

  sig { void }
  def clear_returning; end

  sig { void }
  def clear_type_name; end

  sig { returns(Object) }
  def has_returning?; end

  sig { returns(Object) }
  def has_type_name?; end

  sig { returns(T.nilable(PgQuery::JsonReturning)) }
  def returning; end

  sig { params(value: T.nilable(PgQuery::JsonReturning)).void }
  def returning=(value); end

  sig { returns(T.nilable(PgQuery::TypeName)) }
  def type_name; end

  sig { params(value: T.nilable(PgQuery::TypeName)).void }
  def type_name=(value); end
end
