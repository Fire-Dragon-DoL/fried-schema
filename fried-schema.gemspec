lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fried/schema/version"

Gem::Specification.new do |spec|
  spec.name          = "fried-schema"
  spec.version       = Fried::Schema::VERSION
  spec.authors       = ["Fire-Dragon-DoL"]
  spec.email         = ["francesco.belladonna@gmail.com"]
  spec.licenses      = ["MIT"]

  spec.summary       = %q{Struct definition with type safety}
  spec.description   = %q{Struct definition with type safety}
  spec.homepage      = "https://github.com/Fire-Dragon-DoL/fried-schema"
  spec.metadata      = {
    "source_code_uri" => "https://github.com/Fire-Dragon-DoL/fried-schema"
  }

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-focus"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "fried-test"

  spec.add_runtime_dependency "fried-core"
  spec.add_runtime_dependency "fried-typings"
end
