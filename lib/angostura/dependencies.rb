module Angostura
  module Dependencies
    extend ActiveSupport::Concern

    class_methods do
      mattr_accessor :dependencies

      def setup
        yield self

        dependencies.each do |dependency|
          raise DependencyError.new(dependency) if self.send(dependency).nil?
        end
      end

      def dependency(*args, **kargs)
        self.dependencies = args + kargs&.keys
        self.mattr_accessor(*dependencies)

        kargs.each do |key, default_value|
          self.send("#{key}=", default_value)
        end

        dependencies.each do |dependency|
          define_singleton_method "#{dependency}_class" do
            Object.const_get(self.send(dependency))
          end
        end
      end
    end
  end
end
