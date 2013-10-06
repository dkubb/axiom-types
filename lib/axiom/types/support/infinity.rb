# encoding: utf-8

module Axiom
  module Types

    # Represent an infinite number
    class Infinity < BasicObject
      extend ::Comparable

      # Test the number against infinity
      #
      # @param [Numeric, Infinity] other
      #
      # @return [0]
      #   returned if the other object is infinity
      # @return [1]
      #   returned if the other object is something other than infinity
      #
      # @api private
      def self.<=>(other)
        case other
        when ::BigDecimal                       then 1
        when ->(arg) { arg == number }          then 0
        when ::Numeric, inverse.singleton_class then 1
        end
      end

      # Coerce a number into an Infinity class for comparison
      #
      # @param [::Numeric] other
      #
      # @return [Array(Infinity, Infinity)]
      #
      # @api private
      def self.coerce(other)
        case other
        when ::BigDecimal then [inverse, self]
        when number       then [self,    self]
        when ::Numeric    then [inverse, self]
        else
          raise ::TypeError, "#{other.class} cannot be coerced"
        end
      end

      # Return the next successive object, which is always self
      #
      # @return [Class<Infinity>]
      #
      # @api private
      def self.succ
        self
      end

      # The inverse of infinity
      #
      # @return [Class<NegativeInfinity>]
      #
      # @api private
      def self.inverse
        NegativeInfinity
      end
      private_class_method :inverse

      # The numeric representation of infinity
      #
      # @return [Float]
      #
      # @api private
      def self.number
        ::Float::INFINITY
      end
      private_class_method :number

    end # class Infinity

    # Represent a negative infinite number
    class NegativeInfinity < Infinity

      # Test the number against negative infinity
      #
      # @param [Numeric, Infinity] _other
      #
      # @return [0]
      #   returned if the other object is negative infinity
      # @return [-1]
      #   returned if the other object is not negative infinity
      #
      # @api private
      def self.<=>(_other)
        comparison = super
        -comparison if comparison
      end

      # The inverse of negative infinity
      #
      # @return [Class<Infinity>]
      #
      # @api private
      def self.inverse
        Infinity
      end
      private_class_method :inverse

      # The numeric representation of negative infinity
      #
      # @return [Float]
      #
      # @api private
      def self.number
        -::Float::INFINITY
      end
      private_class_method :number

    end # class NegativeInfinity
  end # module Types
end # module Axiom
