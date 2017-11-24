require "fried/schema/attribute"
require "fried/typings/is"

module Fried::Schema::Attribute
  # Define writer based on attribute {Definition} with type-checking
  class DefineWriter
    attr_accessor :is

    def initialize
      self.is = ::Fried::Typings::Is
    end

    def self.build
      new
    end

    def self.call(attribute_definition, klass)
      instance = build
      instance.(attribute_definition, klass)
    end

    # Creates write method with type-checking
    # @param definition [Definition]
    # @param klass [Class, Module]
    # @return [Definition]
    def call(definition, klass)
      is_a = is[definition.type]
      define_writer(definition, is_a, klass)
    end

    private

    def define_writer(definition, is_a, klass)
      klass.instance_eval do
        define_method(definition.writer) do |value|
          value = is_a.(value)
          instance_variable_set(definition.instance_variable, value)
        end
      end
    end
  end
end
