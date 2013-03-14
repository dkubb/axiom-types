# encoding: utf-8

module Axiom
  module Types

    # Abstract base class for every type
    class Type
      extend Options, DescendantsTracker

      accept_options :constraint
      constraint proc { true }

      # Instantiate a new Axiom::Types::Type subclass
      #
      # @example
      #   type = Axiom::Types::Type.new  # => Axiom::Types::Type
      #
      # @param [#call] constraint
      #   optional constraint for the new type
      #
      # @yield [object]
      #
      # @yieldparam object [Object]
      #   test if the object is the kind of type
      #
      # @yieldreturn [Boolean]
      #   true if the object is the kind of type
      #
      # @return [Class<Axiom::Types::Type>]
      #
      # @api public
      def self.new(constraint = Undefined, &block)
        type = ::Class.new(self, &block)
        type.constraint(constraint)
        type.finalize
      end

      # Finalize by deep freezing the type
      #
      # @return [Axiom::Types::Type]
      #
      # @api private
      def self.finalize
        IceNine.deep_freeze(@constraint)
        freeze
      end

      # Test if the object matches the type constraint
      #
      # @param [Object] object
      #
      # @return [Boolean]
      #
      # @api public
      def self.include?(object)
        included = @constraint.call(object)
        if included != true && included != false
          raise TypeError,
            "constraint must return true or false, but was #{included.inspect}"
        end
        included
      end

      def self.constraint(constraint = Undefined, &block)
        constraint = block if constraint.equal?(Undefined)
        current    = @constraint
        return current if constraint.nil?
        add_constraint(constraint, current)
        self
      end

      # TODO: move this into a module. separate the constraint setup from
      # declaration of the members, like the comparable modules.
      def self.includes(*members)
        set = IceNine.deep_freeze(members.to_set)
        constraint(&set.method(:include?))
      end

      def self.add_constraint(constraint, current)
        @constraint = if current
          lambda { |object| constraint.call(object) && current.call(object) }
        else
          constraint
        end
      end

      private_class_method :includes, :add_constraint

    end # class Type
  end # module Types
end # module Axiom
