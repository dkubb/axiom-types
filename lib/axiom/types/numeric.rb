# encoding: utf-8

module Axiom
  module Types

    # Represents a numeric type
    class Numeric < Object
      primitive       ::Numeric
      coercion_method :to_numeric

    end # class Numeric
  end # module Types
end # module Axiom
