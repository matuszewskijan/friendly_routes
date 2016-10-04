# frozen_string_literal: true

module FriendlyRoutes
  module Params
    # Abstract base class for route params.
    #
    # @abstract
    # @attr [Symbol] type
    # @attr [Symbol, String] name
    class Base
      attr_accessor :type, :name

      def initialize(type, name, optional)
        @type = type
        @name = name
        @optional = optional
      end

      # returns true if param is optional
      def optional?
        @optional == true
      end

      # returns true if param required
      def required?
        @optional == false
      end

      # Regexp with allowed params
      def constraints
        raise NotImplementedError
      end

      # Parse values from request
      #
      # Inverse of {compose}
      def parse
        raise NotImplementedError
      end

      # Generate request value from params
      #
      # Inverse of {parse}
      def compose
        raise NotImplementedError
      end

      # Check if value can be composed
      def allowed?
        raise NotImplementedError
      end
    end
  end
end
