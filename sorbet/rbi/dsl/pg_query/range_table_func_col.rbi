# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::RangeTableFuncCol`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::RangeTableFuncCol`.

class PgQuery::RangeTableFuncCol
  sig do
    params(
      coldefexpr: T.nilable(PgQuery::Node),
      colexpr: T.nilable(PgQuery::Node),
      colname: T.nilable(String),
      for_ordinality: T.nilable(T::Boolean),
      is_not_null: T.nilable(T::Boolean),
      location: T.nilable(Integer),
      type_name: T.nilable(PgQuery::TypeName)
    ).void
  end
  def initialize(coldefexpr: nil, colexpr: nil, colname: nil, for_ordinality: nil, is_not_null: nil, location: nil, type_name: nil); end

  sig { void }
  def clear_coldefexpr; end

  sig { void }
  def clear_colexpr; end

  sig { void }
  def clear_colname; end

  sig { void }
  def clear_for_ordinality; end

  sig { void }
  def clear_is_not_null; end

  sig { void }
  def clear_location; end

  sig { void }
  def clear_type_name; end

  sig { returns(T.nilable(PgQuery::Node)) }
  def coldefexpr; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def coldefexpr=(value); end

  sig { returns(T.nilable(PgQuery::Node)) }
  def colexpr; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def colexpr=(value); end

  sig { returns(String) }
  def colname; end

  sig { params(value: String).void }
  def colname=(value); end

  sig { returns(T::Boolean) }
  def for_ordinality; end

  sig { params(value: T::Boolean).void }
  def for_ordinality=(value); end

  sig { returns(Object) }
  def has_coldefexpr?; end

  sig { returns(Object) }
  def has_colexpr?; end

  sig { returns(Object) }
  def has_type_name?; end

  sig { returns(T::Boolean) }
  def is_not_null; end

  sig { params(value: T::Boolean).void }
  def is_not_null=(value); end

  sig { returns(Integer) }
  def location; end

  sig { params(value: Integer).void }
  def location=(value); end

  sig { returns(T.nilable(PgQuery::TypeName)) }
  def type_name; end

  sig { params(value: T.nilable(PgQuery::TypeName)).void }
  def type_name=(value); end
end
