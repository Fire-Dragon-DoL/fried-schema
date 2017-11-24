require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/get_attribute"

class GetAttributeTest < Minitest::Spec
  AttributeDefinition = ::Fried::Schema::Attribute::Definition
  GetAttribute = ::Fried::Schema::GetAttribute

  it "gets attribute by calling reader method" do
    definition = AttributeDefinition.new(:foo, Numeric, 1)
    obj = Object.new
    obj.define_singleton_method(:foo) { 123 }

    value = GetAttribute.(obj, definition)

    assert value == 123
  end
end
