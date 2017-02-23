module Angostura
  module Dependencies
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      attr_accessor :dependencies

      def setup
        yield self

        dependencies.each do |dependency|
          raise Angostura::DependencyError.new(dependency) if send(dependency).nil?
        end
      end

      def dependency(*args, **kargs)
        self.dependencies = args + kargs&.keys
        singleton_class.send(:attr_reader, *dependencies)

        dependencies.each do |dependency|
          define_singleton_method "#{dependency}=" do |value|
            raise Angostura::DependencyTypeError.new(value) if !value.is_a? String
            self.class_eval("@#{dependency} = value")
          end

          define_singleton_method "#{dependency}_class" do
            Object.const_get(self.send(dependency))
          end
        end

        kargs.each do |key, default_value|
          send("#{key}=", default_value)
        end
      end
    end
  end
end
