$:.push File.expand_path('../lib', __FILE__)

require 'angostura/version'

Gem::Specification.new do |s|
  s.name = 'angostura'
  s.version = Angostura::VERSION
  s.summary = 'Angostura Dependencies!'
  s.description = 'Add dependency setup hook to components easily.'
  s.authors = %w(justin)
  s.email = %w(justin@20dots.com)
  s.files = Dir["{lib}/**/*.rb"]
  s.require_path = 'lib'
  s.homepage = 'https://github.com/justindoody/angostura'
  s.license = 'MIT'

  s.add_development_dependency 'bundler', '~> 1.14'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'binding_of_caller'
end
