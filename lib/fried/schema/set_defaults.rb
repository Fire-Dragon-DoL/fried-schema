require "fried/core"
require "fried/schema/set_attribute_without_checks"

module Fried::Schema
  # Set defaults values for all attributes in schema definitions while
  # ignoring type checking
  class SetDefaults
    attr_accessor :set_attribute_without_checks

    def initialize
      self.set_attribute_without_checks = SetAttributeWithoutChecks.new
    end

    def self.build
      new.tap do |instance|
        instance.set_attribute_without_checks = SetAttributeWithoutChecks.build
      end
    end

    def self.call(schema, obj)
      instance = build
      instance.(schema, obj)
    end

    # @param schema [Definition]
    # @param obj [Object]
    # @return [void]
    def call(schema, obj)
      schema.each_attribute do |attribute|
        value = attribute.extract_default
        set_attribute_without_checks.(obj, attribute, value)
      end
    end
  end
end
