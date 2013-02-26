# encoding: utf-8

module Axiom
  module Types

    # Add a minimum and maximum length constraint to a type
    module LengthComparable

      def self.extended(descendant)
        descendant.accept_options :minimum_length, :maximum_length
      end

      def finalize
        return self if finalized?
        length_between(minimum_length, maximum_length)
        super
      end

    private

      def length_between(minium, maximum)
        constraint { |object| object.length.between?(minium, maximum) }
      end

    end # module LengthComparable
  end # module Types
end # module Axiom
