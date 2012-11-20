require 'rake'
require File.join(File.dirname(__FILE__), "lib", "footing", "version")

Gem::Specification.new do |spec|
  spec.name = 'footing'
  spec.version = '0.1.1'
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/hopsoft/footing'
  spec.summary = 'A utility belt lib.'
  spec.description = <<-DESC
    Footing is a utillity belt library that employs sane monkey patching.
  DESC

  spec.authors = ['Nathan Hopkins']
  spec.email = ['natehop@gmail.com']

  spec.files = FileList[
    'lib/**/*.rb',
    '[A-Z]*',
    'test/**/*.rb'
  ]
end
