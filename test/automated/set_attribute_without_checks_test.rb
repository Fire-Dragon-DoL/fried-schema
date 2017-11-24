require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/set_attribute_without_checks"

class SetAttributeWithoutChecksTest < Minitest::Spec
  AttributeDefinition = ::Fried::Schema::Attribute::Definition
  SetAttributeWithoutChecks = ::Fried::Schema::SetAttributeWithoutChecks

  it "sets attribute by setting instance variable directly" do
    definition = AttributeDefinition.new(:foo, Numeric, 1)
    obj = Object.new

    SetAttributeWithoutChecks.(obj, definition, 123)
    value = obj.instance_variable_get(:@foo)

    assert value == 123
  end
end
