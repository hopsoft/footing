require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'footing'
  spec.version = '0.1.0'
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/hopsoft/footing'
  spec.summary = 'A utility belt library.'
  spec.description = <<-DESC
    Footing is a utillity belt library that employs sane monkey patching.
  DESC

  spec.authors = ['Nathan Hopkins']
  spec.email = ['natehop@gmail.com']

  spec.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*.rb'].to_a
end
