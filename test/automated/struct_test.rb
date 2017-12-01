require "test_helper"
require "fried/schema/struct"

class StructTest < Minitest::Spec
  def setup
    @klass = Class.new do
      include ::Fried::Schema::Struct
    end
  end

  it "provides an attribute macro to define attributes" do
    klass = Class.new { include ::Fried::Schema::Struct }

    klass.attribute :foo, String
    instance = klass.new
    instance.foo = "test"

    assert instance.foo == "test"
  end

  it "allows comparison between structs" do
    klass = Class.new { include ::Fried::Schema::Struct }
    struct = klass.new
    other = klass.new

    comparison = struct <=> other

    assert comparison == 0
  end
end
