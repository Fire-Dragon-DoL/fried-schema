require "fried/core"
require "fried/typings"
require "fried/schema/definition"
require "fried/schema/get_attribute"
require "fried/schema/struct"

module Fried::Schema
  # Compares two {Struct} objects, used for sorting and equality
  class Compare
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

    def self.call(schema, struct, other)
      instance = build
      instance.(schema, struct, other)
    end

    # @param schema [Definition]
    # @param struct [Struct]
    # @param other [Struct]
    # @return [Integer, nil] like `<=>` sign
    def call(schema, struct, other)
      return nil unless struct.class == other.class
      return nil unless Is[Struct].valid?(struct)
      return nil unless Is[Struct].valid?(other)

      compare(schema, struct, other)
    end

    private

    def compare(schema, struct, other)
      comparison = 0

      each_values(schema, struct, other) do |struct_value, other_value|
        next unless struct_value.respond_to?(:"<=>")
        next unless other_value.respond_to?(:"<=>")
        comparison = struct_value <=> other_value
        break if comparison != 0
      end

      comparison
    end

    def same_schema?(schema, struct, other)
      schema.
        each_attribute.
        all? do |attr|
          struct.respond_to?(attr.reader) && other.respond_to?(attr.reader)
        end
    end

    def each_values(schema, struct, other, &block)
      schema.
        each_attribute.
        lazy.
        map { |attr| attr_values_pair(attr, struct, other) }.
        each do |struct_value, other_value|
          block.call(struct_value, other_value)
        end
    end

    def attr_values_pair(attr, struct, other)
      [get_attribute.(struct, attr), get_attribute.(other, attr)]
    end
  end
end
