# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "footing/version"

Gem::Specification.new do |spec|
  spec.name = "footing"
  spec.license = "MIT"
  spec.version = Footing::VERSION
  spec.homepage = "https://github.com/hopsoft/footing"
  spec.summary = "An ActiveSupport style utility library that employs delegation instead of monkey patching"

  spec.authors = ["Nathan Hopkins"]
  spec.email = ["natehop@gmail.com"]

  spec.files = Dir["lib/**/*.rb", "[A-Z]*"]
  spec.test_files = Dir["lib/**/*.rb"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry-test"
  spec.add_development_dependency "coveralls"
end
