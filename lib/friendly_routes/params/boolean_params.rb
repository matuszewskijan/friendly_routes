# frozen_string_literal: true

module FriendlyRoutes
  module Params
    # @attr [String] true value for matching true
    # @attr [String] false value for matching false
    class BooleanParams < Base
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

      # (see Base#parse)
      # @param [String] value request value
      # @return [Boolean]
      def parse(value)
        value == @true
      end

      # (see Base#compose)
      # @param [Boolean]
      # @return [String] request value
      def compose(value)
        value ? @true : @false
      end

      private

      def check_params(options)
        valid = options.is_a?(Hash) && options[:true] && options[:false]
        raise ArgumentError, 'True and false options is required' unless valid
      end
    end
  end
end
