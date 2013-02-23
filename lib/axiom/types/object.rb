# encoding: utf-8

module Axiom
  module Types

    # Represents an object type
    class Object < Type
      accept_options  :primitive, :coercion_method
      primitive       RUBY_VERSION >= '1.9' && defined?(::BasicObject) ? ::BasicObject : ::Object
      coercion_method :to_object

      def self.include?(object)
        primitive === object && super
      end

    end # class Object
  end # module Types
end # module Axiom
