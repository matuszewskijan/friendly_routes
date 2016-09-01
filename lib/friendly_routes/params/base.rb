# frozen_string_literal: true

module FriendlyRoutes
  module Params
    class Base
      attr_accessor :type, :name

      def initialize(type, name, optional)
        @type = type
        @name = name
        @optional = optional
      end

      def optional?
        @optional == true
      end

      def constraints
        raise NotImplementedError
      end
    end
  end
end
