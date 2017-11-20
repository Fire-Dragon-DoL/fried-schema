require "fried/core"

module Fried::Schema
  class Definition
    def initialize(strict: false)
      @strict = strict
    end

    def strict?
      @strict
    end
  end
end
