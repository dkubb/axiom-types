# encoding: utf-8

module Axiom
  module Types

    # Represents an array type
    class Array < Object
      primitive       ::Array
      coercion_method :to_array

    end # class Array
  end # module Types
end # module Axiom
