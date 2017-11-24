require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/set_attribute"

class SetAttributeTest < Minitest::Spec
  AttributeDefinition = ::Fried::Schema::Attribute::Definition
  SetAttribute = ::Fried::Schema::SetAttribute

  it "sets attribute by calling writer method" do
    definition = AttributeDefinition.new(:foo, Numeric, 1)
    obj = Object.new
    obj.define_singleton_method(:foo=) { |v| @foo = v }

    SetAttribute.(obj, definition, 123)
    value = obj.instance_variable_get(:@foo)

    assert value == 123
  end
end
