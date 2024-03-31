# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::SecLabelStmt`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::SecLabelStmt`.

class PgQuery::SecLabelStmt
  sig do
    params(
      label: T.nilable(String),
      object: T.nilable(PgQuery::Node),
      objtype: T.nilable(T.any(Symbol, Integer)),
      provider: T.nilable(String)
    ).void
  end
  def initialize(label: nil, object: nil, objtype: nil, provider: nil); end

  sig { void }
  def clear_label; end

  sig { void }
  def clear_object; end

  sig { void }
  def clear_objtype; end

  sig { void }
  def clear_provider; end

  sig { returns(Object) }
  def has_object?; end

  sig { returns(String) }
  def label; end

  sig { params(value: String).void }
  def label=(value); end

  sig { returns(T.nilable(PgQuery::Node)) }
  def object; end

  sig { params(value: T.nilable(PgQuery::Node)).void }
  def object=(value); end

  sig { returns(T.any(Symbol, Integer)) }
  def objtype; end

  sig { params(value: T.any(Symbol, Integer)).void }
  def objtype=(value); end

  sig { returns(String) }
  def provider; end

  sig { params(value: String).void }
  def provider=(value); end
end
