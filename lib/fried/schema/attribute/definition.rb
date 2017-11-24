require "fried/schema/attribute"

module Fried::Schema::Attribute
  # Value-type holding definition of attribute
  class Definition < Struct.new(:name, :type, :default)
    # @!attribute [rw] name
    #   A {Symbol}
    # @!attribute [rw] type
    #   Any {Class} or {Module}, or {::Fried::Typings::Type}
    # @!attribute [rw] default
    #   Any object. If a {Proc} is used, it will be evaluated during
    #   initialization

    # Attribute reader method name
    # @return [Symbol]
    def reader
      name.to_sym
    end

    # Attribute writer method name
    # @return [Symbol]
    def writer
      :"#{reader}="
    end

    # Attribute instance variable name (@variable)
    # @return [Symbol]
    def instance_variable
      :"@#{reader}"
    end

    # Extracts content of {#default} if it's a {Proc}, otherwise just returns
    # {#default}
    def extract_default
      return default.() if default.is_a?(::Proc)
      default
    end
  end
end
