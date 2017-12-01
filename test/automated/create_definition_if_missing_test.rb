require "test_helper"
require "fried/schema/create_definition_if_missing"
require "fried/schema/get_definition"
require "fried/schema/definition"
require "fried/typings"

class CreateDefinitionIfMissingTest < Minitest::Spec
  include Fried::Typings

  CreateDefinitionIfMissing = ::Fried::Schema::CreateDefinitionIfMissing
  Definition = ::Fried::Schema::Definition
  GetDefinition = ::Fried::Schema::GetDefinition

  it "creates schema definition on instance variable" do
    obj = Object.new

    CreateDefinitionIfMissing.(obj)
    schema = GetDefinition.(obj)

    assert IsStrictly[Definition].valid?(schema)
  end

  it "returns existing definition if already created" do
    obj = Object.new

    schema1 = CreateDefinitionIfMissing.(obj)
    schema2 = CreateDefinitionIfMissing.(obj)

    assert schema1 == schema2
  end
end
