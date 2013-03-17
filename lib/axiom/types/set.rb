# encoding: utf-8

module Axiom
  module Types

    # Represents a set type
    class Set < Object
      primitive       ::Set
      coercion_method :to_set

    end # class Set
  end # module Types
end # module Axiom
