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

      def constraints
        raise NotImplementedError
      end

      # Method for parsing values from request
      #
      # Inverse of {compose}
      def parse
        raise NotImplementedError
      end

      # Method for generating request values from params
      #
      # Inverse of {parse}
      def compose
        raise NotImplementedError
      end
    end
  end
end
