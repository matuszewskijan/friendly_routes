# frozen_string_literal: true

module FriendlyRoutes
  module Params
    class Boolean < Base
      attr_accessor :true, :false

      def initialize(name, options)
        conditions_passed = options[:true] && options[:false]
        raise ArgumentError, 'True and false options is required' unless conditions_passed
        super(:boolean, name)
        @true = options[:true]
        @false = options[:false]
      end
    end
  end
end
