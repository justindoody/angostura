require 'angostura/dependency_error'
require 'angostura/dependency_type_error'
require 'angostura/dependency_value_type_error'
require 'angostura/dependencies'
require 'angostura/dependency/base'
require 'angostura/dependency/env'
require 'angostura/dependency/klass'
require 'ostruct'

module Angostura
  SUPPORTED_TYPES = {
    class: Angostura::Dependency::Klass,
    env: Angostura::Dependency::Env
  }.freeze
  # default: Angostura::Dependency::Default
end
