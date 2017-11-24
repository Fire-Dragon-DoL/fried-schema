require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/definition"
require "fried/schema/hash_to_attributes"

class HashToAttributesTest < Minitest::Spec
  Definition = ::Fried::Schema::Definition
  Attribute = ::Fried::Schema::Attribute
  HashToAttributes = ::Fried::Schema::HashToAttributes

  it "sets attributes on object" do
    definition1 = Attribute::Definition.new(:foo, String, "bar")
    schema = Definition.new
    schema.add_attribute(definition1)
    entity = Object.new
    entity.define_singleton_method(:foo=) { |v| @foo = v }

    HashToAttributes.(schema, { foo: "test" }, entity)
    value = entity.instance_variable_get(:@foo)

    assert value == "test"
  end
end
