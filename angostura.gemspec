$:.push File.expand_path('../lib', __FILE__)

require 'angostura/version'

Gem::Specification.new do |s|
  s.name = 'angostura'
  s.version = Angostura::VERSION
  s.summary = ''
  s.description = ''
  s.authors = %w(justin)
  s.email = %w(justin@20dots.com)
  s.files = ['lib/angostura.rb']
  s.homepage = 'https://github.com/justindoody/angostura'
  s.license = 'MIT'
end
