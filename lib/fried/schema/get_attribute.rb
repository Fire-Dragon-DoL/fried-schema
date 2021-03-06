require "fried/core"

module Fried::Schema
  # Get attribute value from object
  class GetAttribute
    def self.build
      new
    end

    def self.call(obj, attribute)
      instance = build
      instance.(obj, attribute)
    end

    # @param obj [Object] anything
    # @param attribute [Attribute::Definition]
    # @return [Object] value from the object attribute
    def call(obj, attribute)
      reader = attribute.reader
      obj.public_send(reader)
    end
  end
end
