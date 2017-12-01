require "test_helper"
require "fried/schema/compare"
require "fried/schema/get_definition"
require "fried/schema/struct"

class CompareTest < Minitest::Spec
  Compare = ::Fried::Schema::Compare
  GetDefinition = ::Fried::Schema::GetDefinition

  def setup
    @struct_class = Class.new do
      include ::Fried::Schema::Struct
      attribute :foo, String
      attribute :bar, Numeric
    end
    @schema = GetDefinition.(@struct_class)
  end

  it "is nil when struct and other are not the same class" do
    struct = @struct_class.new
    other = @struct_class.dup.new

    comparison = Compare.(@schema, struct, other)

    assert comparison.nil?
  end

  it "is nil when struct is not a Struct" do
    struct = Object.new
    other = @struct_class.new

    comparison = Compare.(@schema, struct, other)

    assert comparison.nil?
  end

  it "is nil when other is not a Struct" do
    struct = @struct_class.new
    other = Object.new

    comparison = Compare.(@schema, struct, other)

    assert comparison.nil?
  end

  it "isn't nil when both objects are a Struct" do
    struct = @struct_class.new
    other = @struct_class.new

    comparison = Compare.(@schema, struct, other)

    refute comparison.nil?
  end

  it "isn't same when objects have different data" do
    struct = @struct_class.new
    struct.foo = "bar"
    other = @struct_class.new

    comparison = Compare.(@schema, struct, other)

    assert comparison != 0
  end

  it "is the same when objects have same data" do
    struct = @struct_class.new
    struct.foo = "bar"
    other = @struct_class.new
    other.foo = "bar"

    comparison = Compare.(@schema, struct, other)

    assert comparison == 0
  end

  it "isn't the same when objects don't have all same data" do
    struct = @struct_class.new
    struct.foo = "bar"
    other = @struct_class.new
    other.foo = "bar"
    other.bar = 123

    comparison = Compare.(@schema, struct, other)

    assert comparison != 0
  end

  it "is the same when objects have all same data" do
    struct = @struct_class.new
    struct.foo = "bar"
    struct.bar = 123
    other = @struct_class.new
    other.foo = "bar"
    other.bar = 123

    comparison = Compare.(@schema, struct, other)

    assert comparison == 0
  end
end
