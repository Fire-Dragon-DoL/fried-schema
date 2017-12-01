require "fried/core"

module Fried::Schema
  # Get schema definition from {Struct}
  class GetDefinition
    def self.build
      new
    end

    def self.call(obj)
      instance = build
      instance.(obj)
    end

    # @param obj [Class] a {Struct} or {DataEntity} class
    # @return [Definition]
    def call(obj)
      obj.instance_variable_get(:@__fried_schema__)
    end
  end
end
