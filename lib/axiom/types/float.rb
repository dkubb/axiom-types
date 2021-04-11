module Axiom
  module Types

    # Represents a decimal type
    class Float < Numeric
      primitive       ::Float
      coercion_method :to_float

      minimum -primitive::MAX
      maximum primitive::MAX

    end # class Float
  end # module Types
end # module Axiom
