require "fried/core"

module Fried::Schema
  # Holds defined attributes for a given {Class}
  class Definition
    private

    attr_reader :attributes

    public

    def initialize
      @attributes = {}
    end

    # @param attribute_definition [Attribute::Definition]
    # @return [Attribute::Definition]
    def add_attribute(definition)
      name = definition.name
      attributes[name] = definition
    end

    # List all attributes. If no block is passed, returns an enumerator,
    # otherwise it returns the last value returned by the block
    # @return [Enumerator, Object]
    def each_attribute(&block)
      return attributes_enumerator if block.nil?

      attributes_enumerator.each(&block)
    end

    private

    def attributes_enumerator
      Enumerator.new(attributes.size) do |yielder|
        attributes.each { |_, definition| yielder << definition }
      end
    end
  end
end
