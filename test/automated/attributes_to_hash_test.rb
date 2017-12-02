require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/attributes_to_hash"
require "fried/schema/definition"
require "fried/schema/data_entity"
require "fried/schema/get_definition"

class AttributesToHashTest < Minitest::Spec
  Definition = ::Fried::Schema::Definition
  Attribute = ::Fried::Schema::Attribute
  AttributesToHash = ::Fried::Schema::AttributesToHash
  GetDefinition = ::Fried::Schema::GetDefinition

  it "returns a Hash of attributes" do
    definition1 = Attribute::Definition.new(:foo, String, "bar")
    definition2 = Attribute::Definition.new(:bar, Numeric, 123)
    schema = Definition.new
    schema.add_attribute(definition1)
    schema.add_attribute(definition2)
    entity = Object.new
    entity.define_singleton_method(:foo) { "bar" }
    entity.define_singleton_method(:bar) { 123 }

    hash = AttributesToHash.(schema, entity)

    assert hash == { foo: "bar", bar: 123 }
  end

  it "converts nested data entities to hash" do
    klass = Class.new do
      include Fried::Schema::DataEntity
      attribute :blah, Numeric
    end
    other_klass = Class.new do
      include Fried::Schema::DataEntity
      attribute :foo, String
      attribute :bar, klass
    end
    entity = klass.build(blah: 123)
    entity2 = other_klass.build(foo: "bar", bar: entity)
    schema = GetDefinition.(other_klass)

    hash = AttributesToHash.(schema, entity2)

    assert hash == { foo: "bar", bar: { blah: 123 } }
  end
end
