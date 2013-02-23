# encoding: utf-8

module Axiom
  module Types

    # Represents a date time type
    class DateTime < Object
      extend ValueComparable

      MAXIMUM_NSEC_IN_SECONDS = 1 - Rational(1, 10**9)

      primitive       ::DateTime
      coercion_method :to_datetime

      minimum primitive.new(1, 1, 1)
      maximum primitive.new(9999, 12, 31, 23, 59, 59 + MAXIMUM_NSEC_IN_SECONDS)

    end # class DateTime
  end # module Types
end # module Axiom
