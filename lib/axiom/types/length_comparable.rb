# encoding: utf-8

module Axiom
  module Types

    # Add a minimum and maximum length constraint to a type
    module LengthComparable

      def self.extended(descendant)
        descendant.accept_options :minimum_length, :maximum_length
      end

      def length_between(minium, maximum)
        constraint do |object|
          object.respond_to?(:length) && object.length.between?(minium, maximum)
        end
      end

      def finalize
        length_between(minimum_length, maximum_length)
        super
      end

    end # module LengthComparable
  end # module Types
end # module Axiom
