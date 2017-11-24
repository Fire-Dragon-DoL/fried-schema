require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/set_defaults"

class SetDefaultsTest < Minitest::Spec
  AttributeDefinition = ::Fried::Schema::Attribute::Definition
  Definition = ::Fried::Schema::Definition
  SetDefaults = ::Fried::Schema::SetDefaults

  it "sets attribute by calling writer method" do
    definition1 = AttributeDefinition.new(:foo, Numeric, 1)
    definition2 = AttributeDefinition.new(:bar, String, "test")
    schema = Definition.new
    schema.add_attribute(definition1)
    schema.add_attribute(definition2)
    obj = Object.new

    SetDefaults.(schema, obj)
    values = [
      obj.instance_variable_get(:@foo),
      obj.instance_variable_get(:@bar)
    ]

    assert values == [1, "test"]
  end
end
