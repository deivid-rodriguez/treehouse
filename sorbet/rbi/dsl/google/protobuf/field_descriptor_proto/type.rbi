# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Google::Protobuf::FieldDescriptorProto::Type`.
# Please instead update this file by running `bin/tapioca dsl Google::Protobuf::FieldDescriptorProto::Type`.

module Google::Protobuf::FieldDescriptorProto::Type
  class << self
    sig { returns(Google::Protobuf::EnumDescriptor) }
    def descriptor; end

    sig { params(number: Integer).returns(T.nilable(Symbol)) }
    def lookup(number); end

    sig { params(symbol: Symbol).returns(T.nilable(Integer)) }
    def resolve(symbol); end
  end
end

Google::Protobuf::FieldDescriptorProto::Type::TYPE_BOOL = 8
Google::Protobuf::FieldDescriptorProto::Type::TYPE_BYTES = 12
Google::Protobuf::FieldDescriptorProto::Type::TYPE_DOUBLE = 1
Google::Protobuf::FieldDescriptorProto::Type::TYPE_ENUM = 14
Google::Protobuf::FieldDescriptorProto::Type::TYPE_FIXED32 = 7
Google::Protobuf::FieldDescriptorProto::Type::TYPE_FIXED64 = 6
Google::Protobuf::FieldDescriptorProto::Type::TYPE_FLOAT = 2
Google::Protobuf::FieldDescriptorProto::Type::TYPE_GROUP = 10
Google::Protobuf::FieldDescriptorProto::Type::TYPE_INT32 = 5
Google::Protobuf::FieldDescriptorProto::Type::TYPE_INT64 = 3
Google::Protobuf::FieldDescriptorProto::Type::TYPE_MESSAGE = 11
Google::Protobuf::FieldDescriptorProto::Type::TYPE_SFIXED32 = 15
Google::Protobuf::FieldDescriptorProto::Type::TYPE_SFIXED64 = 16
Google::Protobuf::FieldDescriptorProto::Type::TYPE_SINT32 = 17
Google::Protobuf::FieldDescriptorProto::Type::TYPE_SINT64 = 18
Google::Protobuf::FieldDescriptorProto::Type::TYPE_STRING = 9
Google::Protobuf::FieldDescriptorProto::Type::TYPE_UINT32 = 13
Google::Protobuf::FieldDescriptorProto::Type::TYPE_UINT64 = 4