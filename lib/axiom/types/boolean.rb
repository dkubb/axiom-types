# encoding: utf-8

module Axiom
  module Types

    # Represents a boolean type
    class Boolean < Object
      coercion_method :to_boolean

      includes true, false

    end # class Boolean
  end # module Types
end # module Axiom
