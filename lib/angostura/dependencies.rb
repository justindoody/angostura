module Angostura
  module Dependencies
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def dependencies
        @@dependencies
      end

      def dependencies=(value)
        @@dependencies = value
      end

      def setup
        yield self

        dependencies.each do |dependency|
          raise Angostura::DependencyError.new(dependency) if self.send(dependency).nil?
        end
      end

      def dependency(*args, **kargs)
        self.dependencies = args + kargs&.keys

        dependencies.each do |dependency|
          class_eval("@@#{dependency} = nil")

          self.define_singleton_method "#{dependency}" do
            class_eval("@@#{dependency}")
          end

          self.define_singleton_method "#{dependency}=" do |value|
            class_eval("@@#{dependency} = '#{value}'")
          end

          self.define_singleton_method "#{dependency}_class" do
            Object.const_get(self.send(dependency))
          end
        end

        kargs.each do |key, default_value|
          self.send("#{key}=", default_value)
        end
      end
    end
  end
end
