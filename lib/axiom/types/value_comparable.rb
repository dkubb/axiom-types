# encoding: utf-8

module Axiom
  module Types

    # Add a minimum and maximum constraint to a type
    module ValueComparable

      # Hook called when module is extended
      #
      # Add #minimum and #maximum DSL methods to descendant.
      #
      # @param [Class<Axiom::Types::Type>] descendant
      #
      # @return [undefined]
      #
      # @api private
      def self.extended(descendant)
        super
        descendant.accept_options :minimum, :maximum
      end

      # Finalize by setting up a value range constraint
      #
      # @return [Axiom::Types::ValueComparable]
      #
      # @api private
      def finalize
        return self if frozen?
        has_value_within_range
        super
      end

    private

      # Add a constraint for a value within a range
      #
      # @return [undefined]
      #
      # @api private
      def has_value_within_range
        constraint { |object| object.between?(minimum, maximum) }
      end

    end # module ValueComparable
  end # module Types
end # module Axiom
