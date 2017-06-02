module Angostura
  module Dependency
    class Env < Base
      def generate(component:)
        component.env.send("#{name}=", default)
      end

      def missing?(component:)
        component.env.send(name).nil?
      end
    end
  end
end
