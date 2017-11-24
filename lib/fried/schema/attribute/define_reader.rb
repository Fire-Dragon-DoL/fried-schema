require "fried/schema/attribute"

module Fried::Schema::Attribute
  # Define reader based on attribute {Definition}
  class DefineReader
    def self.build
      new
    end

    def self.call(attribute_definition, klass)
      instance = build
      instance.(attribute_definition, klass)
    end

    # Creates read method
    # @param definition [Definition]
    # @param klass [Class, Module]
    # @return [Definition]
    def call(definition, klass)
      variable = definition.instance_variable

      klass.instance_eval do
        define_method(definition.reader) { instance_variable_get(variable) }
      end
    end
  end
end
