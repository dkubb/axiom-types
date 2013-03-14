# encoding: utf-8

module Axiom
  module Types

    # Add a minimum and maximum constraint to a type
    module ValueComparable

      def self.extended(descendant)
        descendant.accept_options :minimum, :maximum
      end

      def finalize
        return self if frozen?
        value_between(IceNine.deep_freeze(minimum), IceNine.deep_freeze(maximum))
        super
      end

    private

      def value_between(minium, maximum)
        constraint { |object| object.between?(minium, maximum) }
      end

    end # module ValueComparable
  end # module Types
end # module Axiom
