require "test_helper"
require "fried/schema/attribute/definition"
require "fried/schema/attribute/define_reader"

class DefineReaderTest < Minitest::Spec
  Attribute = ::Fried::Schema::Attribute

  def setup
    @klass = Class.new
  end

  it "adds a reader method based on attribute definition" do
    definition = Attribute::Definition.new(:foo, String, "test")

    Attribute::DefineReader.(definition, @klass)
    instance = @klass.new
    instance.instance_variable_set(:@foo, "bar")

    assert instance.foo == "bar"
  end
end
