require "fried/core"
require "fried/schema/definition"

module Fried::Schema
  module Loose
    def schema(&block)
      return @__fried_schema__ if block.nil?

      definition = ::Fried::Schema::Definition.new(strict: false)
      definition.instance_eval(&block)

      @__fried_schema__ = definition
    end
  end
end
