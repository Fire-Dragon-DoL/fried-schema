require "fried/core"
require "fried/schema/get_attribute"

module Fried::Schema
  # Converts all attributes into a {Hash} of name => value
  class AttributesToHash
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
        hash[attribute.name] = value
        hash
      end
    end
  end
end
