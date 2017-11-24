require "fried/schema/attribute"
require "fried/schema/attribute/define_reader"
require "fried/schema/attribute/define_writer"

module Fried::Schema::Attribute
  # Define methods based on attributes registered in
  # {::Fried::Schema::Definition}
  class DefineMethods
    attr_accessor :define_reader
    attr_accessor :define_writer

    def initialize
      self.define_reader = ::Fried::Schema::Attribute::DefineReader.new
      self.define_writer = ::Fried::Schema::Attribute::DefineWriter.new
    end

    def self.build
      new.tap do |instance|
        instance.define_reader = ::Fried::Schema::Attribute::DefineReader.build
        instance.define_writer = ::Fried::Schema::Attribute::DefineWriter.build
      end
    end

    def self.call(attribute_definition, klass)
      instance = build
      instance.(attribute_definition, klass)
    end

    # Creates methods to read/write attribute with type checking
    # @param attribute_definition [AttributeDefinition]
    # @param klass [Class, Module]
    # @return [AttributeDefinition]
    def call(attribute_definition, klass)
      define_reader.(attribute_definition, klass)
      define_writer.(attribute_definition, klass)
      attribute_definition
    end
  end
end
