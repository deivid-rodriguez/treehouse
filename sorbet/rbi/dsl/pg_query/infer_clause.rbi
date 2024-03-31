# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::InferClause`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::InferClause`.

class PgQuery::InferClause
  sig do
    params(
      conname: T.nilable(String),
      index_elems: T.nilable(T.any(Google::Protobuf::RepeatedField[PgQuery::Node], T::Array[PgQuery::Node])),
      location: T.nilable(Integer),
      where_clause: T.nilable(PgQuery::Node)
    ).void
  end
  def initialize(conname: nil, index_elems: T.unsafe(nil), location: nil, where_clause: nil); end

  sig { void }
  def clear_conname; end

  sig { void }
  def clear_index_elems; end

  sig { void }
  def clear_location; end

  sig { void }
  def clear_where_clause; end

  sig { returns(String) }
  def conname; end

  sig { params(value: String).void }
  def conname=(value); end

  sig { returns(Object) }
  def has_where_clause?; end

  sig { returns(Google::Protobuf::RepeatedField[PgQuery::Node]) }
  def index_elems; end

  sig { params(value: Google::Protobuf::RepeatedField[PgQuery::Node]).void }
  def index_elems=(value); end

  sig { returns(Integer) }
  def location; end

  sig { params(value: Integer).void }
  def location=(value); end

  sig { returns(T.nilable(PgQuery::Node)) }
  def where_clause; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def where_clause=(value); end
end
