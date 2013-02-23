# encoding: utf-8

module Axiom
  module Types

    # Represents a date time type
    class Time < Object
      extend ValueComparable

      primitive       ::Time
      coercion_method :to_time

      minimum primitive.utc(1, 1, 1)
      maximum primitive.utc(9999, 12, 31, 23, 59, 59, 999999)

    end # class Time
  end # module Types
end # module Axiom
