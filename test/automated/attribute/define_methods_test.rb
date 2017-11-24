require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/attribute/define_methods"

class DefineMethodsTest < Minitest::Spec
  Attribute = ::Fried::Schema::Attribute

  def setup
    @klass = Class.new
  end

  it "adds a writer and reader method based on attribute definition" do
    definition = Attribute::Definition.new(:foo, String, "test")

    Attribute::DefineMethods.(definition, @klass)
    instance = @klass.new
    instance.foo = "foo"
    value = instance.foo

    assert value == "foo"
  end

  it "returns attribute definition" do
    definition = Attribute::Definition.new(:foo, String, "test")

    other_definition = Attribute::DefineMethods.(definition, @klass)

    assert definition == other_definition
  end
end
