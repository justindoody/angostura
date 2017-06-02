module Angostura
  module Dependencies
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      attr_writer :dependencies

      def dependencies
        @_dependencies ||= []
      end

      def env
        @_env ||= OpenStruct.new
      end

      def setup
        yield self

        dependencies.each do |dependency|
          # raise Angostura::DependencyError.new(dependency.name) if send(dependency.name).nil?
          raise Angostura::DependencyError.new(dependency.name) if dependency.missing?(component: self)
        end
      end

      def dependency(dependency_name, type: :default, default: nil)
        type = type.to_sym

        raise Angostura::DependencyTypeError.new(type) if !SUPPORTED_TYPES.keys.include?(type)

        dependency = SUPPORTED_TYPES[type].new(name: dependency_name, default: default)

        self.dependencies << dependency

        dependency.generate(component: self)
      end
    end
  end
end
