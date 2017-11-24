require "test_helper"
require "fried/schema/data_entity"

class DataEntityTest < Minitest::Spec
  def setup
    @klass = Class.new do
      include ::Fried::Schema::DataEntity

      attribute :name, String
    end
  end

  it "builds entity from hashmap" do
    obj = @klass.build(name: "foo")

    assert obj.name == "foo"
  end

  it "returns hash from #to_h" do
    obj = @klass.build(name: "foo")

    assert obj.to_h == { name: "foo" }
  end
end
