require "fried/core"
require "fried/schema/get_definition"
require "fried/schema/definition"

module Fried::Schema
  # Creates schema definition if missing
  class CreateDefinitionIfMissing
    attr_accessor :get_definition

    def self.build
      new.tap do |instance|
        instance.get_definition = GetDefinition.build
      end
    end

    def self.call(obj)
      instance = build
      instance.(obj)
    end

    # @param obj [Class] a {Struct} or {DataEntity} class
    # @return [Definition]
    def call(obj)
      schema = get_definition.(obj)

      schema || obj.instance_variable_set(:@__fried_schema__, Definition.new)
    end
  end
end
