# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `PgQuery::DropBehavior`.
# Please instead update this file by running `bin/tapioca dsl PgQuery::DropBehavior`.

module PgQuery::DropBehavior
  class << self
    sig { returns(Google::Protobuf::EnumDescriptor) }
    def descriptor; end

    sig { params(number: Integer).returns(T.nilable(Symbol)) }
    def lookup(number); end

    sig { params(symbol: Symbol).returns(T.nilable(Integer)) }
    def resolve(symbol); end
  end
end

PgQuery::DropBehavior::DROP_BEHAVIOR_UNDEFINED = 0
PgQuery::DropBehavior::DROP_CASCADE = 2
PgQuery::DropBehavior::DROP_RESTRICT = 1