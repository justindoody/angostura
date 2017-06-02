module Angostura
  module Dependency
    class Klass < Base
      def generate(component:)
        component.singleton_class.send(:attr_reader, name)

        component.define_singleton_method "#{name}=" do |value|
          raise Angostura::DependencyValueTypeError.new(value) if !value.is_a? String
          self.class_eval("@#{__method__.to_s.chomp('=')} = value")
        end

        component.define_singleton_method "#{name}_class" do
          Object.const_get(self.send(__method__.to_s.chomp('_class')))
        end

        component.send("#{name}=", default) unless default.nil?
      end

      def missing?(component:)
        component.send(name).nil?
      end
    end
  end
end
