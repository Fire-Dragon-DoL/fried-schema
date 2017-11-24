require "test_helper"
require "fried/schema/attribute/definition"

class DefinitionTest < Minitest::Spec
  Attribute = ::Fried::Schema::Attribute

  it "has #reader returning name symbolized" do
    definition = Attribute::Definition.new("foo", String, "test")

    assert definition.reader == :foo
  end

  it "has #writer returning name symbolized with equal sign" do
    definition = Attribute::Definition.new(:foo, String, "test")

    assert definition.writer == :foo=
  end

  it "has #instance_variable returning @name symbolized" do
    definition = Attribute::Definition.new(:foo, String, "test")

    assert definition.instance_variable == :@foo
  end

  it "has #extract_default returning content of #default when not Proc" do
    definition = Attribute::Definition.new(:foo, String, "test")

    assert definition.extract_default == "test"
  end

  it "has #extract_default returning content of #default#call when Proc" do
    definition = Attribute::Definition.new(:foo, String, -> { "test" })

    assert definition.extract_default == "test"
  end
end
