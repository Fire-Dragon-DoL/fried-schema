require "minitest/spec"
require "pry-byebug"
require "minitest/reporters"
require "minitest/focus"

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new
