module Angostura
  module Dependency
    class Base
      def initialize(name:, default:)
        self.name = name
        self.default = default
      end

      attr_reader :name, :default

      def generate; end

      private

        attr_writer :name, :default
    end
  end
end
