require "fried/core"
require "fried/schema/get_definition"
require "fried/schema/struct"
require "fried/schema/attributes_to_hash"
require "fried/schema/hash_to_attributes"

module Fried::Schema
  # Includes {Struct} but also provide a {.build} method which initialize
  # the object with a {Hash}, setting attributes based on keys
  module DataEntity
    module ClassMethods
      def build(attributes = {})
        new.tap do |instance|
          schema = GetDefinition.(self)
          HashToAttributes.(schema, attributes, instance)
        end
      end
    end

    # @return [Hash{Symbol => Object}] a hash containing the values of all
    #   attribute name => value
    def to_h
      schema = GetDefinition.(self.class)
      AttributesToHash.(schema, self)
    end

    def self.included(klass)
      klass.instance_eval do
        include ::Fried::Schema::Struct
        extend ClassMethods
      end
    end
  end
end
