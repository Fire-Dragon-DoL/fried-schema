require "fried/core"
require "fried/schema/set_attribute"

module Fried::Schema
  # Sets all attributes based on hash
  class HashToAttributes
    attr_accessor :set_attribute

    def initialize
      self.set_attribute = SetAttribute.new
    end

    def self.build
      new.tap do |instance|
        instance.set_attribute = SetAttribute.build
      end
    end

    def self.call(schema, attributes, obj)
      instance = build
      instance.(schema, attributes, obj)
    end

    # @param schema [Definition]
    # @param attributes [Hash{Symbol => Object}]
    # @param obj [::Fried::Schema::Struct] an instance of a class including
    #   {::Fried::Schema::Struct}
    # @return [void]
    def call(schema, attributes, obj)
      schema.each_attribute do |attribute|
        next unless attributes.has_key?(attribute.name)
        value = attributes[attribute.name]
        set_attribute.(obj, attribute, value)
      end
    end
  end
end
