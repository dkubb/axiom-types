# encoding: utf-8

module Axiom
  module Types

    # Add a minimum and maximum length constraint to a type
    module LengthComparable

      # Hook called when module is extended
      #
      # Add #minimum_length and #maximum_length DSL methods to descendant.
      #
      # @param [Class<Axiom::Types::Type>] descendant
      #
      # @return [undefined]
      #
      # @api private
      def self.extended(descendant)
        super
        descendant.accept_options :minimum_length, :maximum_length
      end

      # Finalize by setting up a length range constraint
      #
      # @return [Axiom::Types::LengthComparable]
      #
      # @api private
      def finalize
        return self if frozen?
        has_length_within_range
        super
      end

    private

      # Add a constraint for a length within a range
      #
      # @return [undefined]
      #
      # @todo freeze the minimum_length and maximum_length
      #
      # @api private
      def has_length_within_range
        constraint do |object|
          object.length.between?(minimum_length, maximum_length)
        end
      end

    end # module LengthComparable
  end # module Types
end # module Axiom
