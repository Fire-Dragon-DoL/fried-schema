require "test_helper"
require "fried/schema/get_definition"
require "fried/schema/struct"

class GetDefinitionTest < Minitest::Spec
  GetDefinition = ::Fried::Schema::GetDefinition

  it "gets schema definition from instance variable" do
    obj = Object.new
    obj.instance_variable_set(:@__fried_schema__, 123)

    schema = GetDefinition.(obj)

    assert schema == 123
  end
end
