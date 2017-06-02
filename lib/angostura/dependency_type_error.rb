module Angostura
  class DependencyTypeError < StandardError
    def initialize(dependency)
      super("Tried to setup a nonexistent dependency type #{dependency}.")
    end
  end
end
