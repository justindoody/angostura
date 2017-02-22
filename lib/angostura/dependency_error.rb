module Angostura
  class DependencyError < StandardError
    def initialize(missing_dependency)
      super("Component requires setting a #{missing_dependency} dependency.")
    end
  end
end
