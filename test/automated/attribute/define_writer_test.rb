require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/attribute/define_writer"

class DefineWriterTest < Minitest::Spec
  Attribute = ::Fried::Schema::Attribute

  def setup
    @klass = Class.new
  end

  it "adds a writer method based on attribute definition" do
    definition = Attribute::Definition.new(:foo, String, "test")

    Attribute::DefineWriter.(definition, @klass)
    instance = @klass.new
    instance.foo = "foo"
    value = instance.instance_variable_get(:@foo)

    assert value == "foo"
  end
end
