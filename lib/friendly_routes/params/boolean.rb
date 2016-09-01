# frozen_string_literal: true

module FriendlyRoutes
  module Params
    class Boolean < Base
      attr_accessor :true, :false

      def initialize(name, options, optional: true)
        check_params(options)
        super(:boolean, name, optional)
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

      def check_params(options)
        valid = options.is_a?(Hash) && options[:true] && options[:false]
        raise ArgumentError, 'True and false options is required' unless valid
      end
    end
  end
end
