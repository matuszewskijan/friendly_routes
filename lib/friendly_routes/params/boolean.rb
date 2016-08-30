# frozen_string_literal: true

module FriendlyRoutes
  module Params
    class Boolean < Base
      attr_accessor :true, :false

      def initialize(name, options)
        check_options(options)
        super(:boolean, name)
        @true = options[:true]
        @false = options[:false]
      end

      def constraints
        Regexp.new "#{@true}|#{@false}"
      end

      def parse(value)
        value == @true
      end

      private

      def check_options(options)
        conditions_passed = options.is_a?(Hash) && options[:true] && options[:false]
        raise ArgumentError, 'True and false options is required' unless conditions_passed
      end
    end
  end
end
