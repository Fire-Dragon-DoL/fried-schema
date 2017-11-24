require "fried/core"
require "fried/schema/attribute/definition"
require "fried/schema/attribute/define_methods"
require "fried/schema/definition"
require "fried/schema/set_defaults"

module Fried::Schema
  # Provides {.attribute} macro which allows to easily define type-safe
  # accessors. The attributes are initialized with default values or with
  # {nil} if none was provided
  module Struct
    module Initializer
      def initialize
        schema = self.class.instance_variable_get(:@__fried_schema__)
        ::Fried::Schema::SetDefaults.(schema, self)
      end
    end

    module ClassMethods
      Noop = -> { nil }

      # Defines an attr_accessor with given name, type checking and optional
      # default value
      # @param name [Symbol, String] name for attribute (attr_accessor)
      # @param type [::Fried::Typings::Type, Class, Module] either a `Type`
      #   from `Fried::Typings` (even a custom one) or any `Class` or `Module`
      # @param default [Object, Proc] if an object is passed, it will be used
      #   as default. If a {Proc} is passed, it will be evaluated during
      #   object initialization
      # @return [Symbol] reader method name
      def attribute(name, type, default: Noop)
        @__fried_schema__ ||= ::Fried::Schema::Definition.new
        definer = ::Fried::Schema::Attribute::Definition
        attribute_definition = definer.new(name, type, default)
        @__fried_schema__.add_attribute(attribute_definition)
        ::Fried::Schema::Attribute::DefineMethods.(attribute_definition, self)
      end
    end

    def self.included(klass)
      klass.instance_eval do
        include Initializer
        extend ClassMethods
      end
    end
  end
end
