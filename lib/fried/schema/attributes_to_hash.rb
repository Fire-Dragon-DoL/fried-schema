require "fried/core"
require "fried/schema/data_entity"
require "fried/schema/get_attribute"
require "fried/schema/get_definition"
require "fried/typings"

module Fried::Schema
  # Converts all attributes into a {Hash} of name => value. It calls {#to_h} on
  # each value that is a {DataEntity}
  class AttributesToHash
    include ::Fried::Typings

    attr_accessor :get_attribute

    def initialize
      self.get_attribute = GetAttribute.new
    end

    def self.build
      new.tap do |instance|
        instance.get_attribute = GetAttribute.build
      end
    end

    def self.call(schema, obj)
      instance = build
      instance.(schema, obj)
    end

    # @param schema [Definition]
    # @param obj [::Fried::Schema::Struct] an instance of a class including
    #   {::Fried::Schema::Struct}
    # @return [Hash{Symbol => Object}] hash of attributes key => values
    def call(schema, obj)
      schema.each_attribute.inject({}) do |hash, attribute|
        value = get_attribute.(obj, attribute)
        hash[attribute.name] = value_to_h(value)
        hash
      end
    end

    private

    def value_to_h(value)
      return value unless Is[DataEntity].valid?(value)

      schema = GetDefinition.(value.class)
      call(schema, value)
    end
  end
end
