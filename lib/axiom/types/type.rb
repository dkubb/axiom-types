# encoding: utf-8

module Axiom
  module Types

    # Abstract base class for every type
    class Type
      extend Options, DescendantsTracker

      accept_options :constraint
      constraint proc { true }

      def self.new
        raise NotImplementedError, "#{inspect} should not be instantiated"
      end

      def self.constraint(constraint = nil, &block)
        constraint ||= block
        current      = @constraint
        return current if constraint.nil?
        @constraint = if current
          lambda { |object| current.call(object) && constraint.call(object) }
        else
          constraint
        end
        self
      end

      def self.includes(*set)
        set.uniq!
        constraint { |object| set.include?(object) }
      end

      def self.include?(object)
        included = constraint.call(object)
        if included != true && included != false
          raise TypeError, "must return true or false, but was #{included.inspect}"
        end
        included
      end

      def self.finalize
        IceNine.deep_freeze(self)
      end

    end # class Type
  end # module Types
end # module Axiom
