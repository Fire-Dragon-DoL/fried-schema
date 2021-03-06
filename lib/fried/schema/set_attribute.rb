require "fried/core"

module Fried::Schema
  # Set attribute value on object
  class SetAttribute
    def self.build
      new
    end

    def self.call(obj, attribute, value)
      instance = build
      instance.(obj, attribute, value)
    end

    # @param obj [Object] anything
    # @param attribute [Attribute::Definition]
    # @param value [Object] anything
    # @return [Object] the passed value
    def call(obj, attribute, value)
      writer = attribute.writer
      obj.public_send(writer, value)
    end
  end
end
