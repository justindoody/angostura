module Angostura
  class DependencyValueTypeError < StandardError
    def initialize(dependency)
      super("Component requires setting a dependency as a stringified class name, you set #{dependency}.")
    end
  end
end
