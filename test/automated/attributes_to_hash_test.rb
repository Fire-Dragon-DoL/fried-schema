require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/attributes_to_hash"
require "fried/schema/definition"

class AttributesToHashTest < Minitest::Spec
  Definition = ::Fried::Schema::Definition
  Attribute = ::Fried::Schema::Attribute
  AttributesToHash = ::Fried::Schema::AttributesToHash

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
end
