require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'footing'
  spec.version = '0.0.6'
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/hopsoft/footing'
  spec.summary = 'Foundational patching lib.'
  spec.description = <<-DESC
    Footing provides some sanity for monkey patching practices.
    It's also a utility lib that contains additional functionality for core objects that you might find useful.
  DESC

  spec.authors = ['Nathan Hopkins']
  spec.email = ['natehop@gmail.com']

  spec.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*.rb'].to_a
end
