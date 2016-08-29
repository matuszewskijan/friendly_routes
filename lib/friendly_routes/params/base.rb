# frozen_string_literal: true

module FriendlyRoutes
  module Params
    class Base
      attr_accessor :type, :name

      def initialize(type, name)
        @type = type
        @name = name
      end

      def constraints
        raise NotImplementedError
      end
    end
  end
end
