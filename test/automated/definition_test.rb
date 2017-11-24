require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/definition"

class DefinitionTest < Minitest::Spec
  AttributeDefinition = ::Fried::Schema::Attribute::Definition
  Definition = ::Fried::Schema::Definition

  it "adds attribute to definition" do
    definition = Definition.new
    attribute = AttributeDefinition.new(:name, String, "foo")

    definition.add_attribute(attribute)
    other_attribute = definition.each_attribute.first

    assert other_attribute == attribute
  end
end
