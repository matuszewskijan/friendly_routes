# frozen_string_literal: true

module FriendlyRoutes
  module Params
    # @attr [Hash] hash *keys* are values for matching and *values* is needed values
    class HashParams < Base
      attr_accessor :hash

      def initialize(name, hash, optional: true)
        super(:collection, name, optional)
        @hash = hash
        check_params
      end

      def constraints
        Regexp.new @hash.keys.join('|')
      end

      # (see Base#parse)
      # @param [String, Symbol] value hash key
      # @return [Object] hash value
      def parse(value)
        @hash[value]
      end

      # (see Base#compose)
      # @param [Object] value hash value
      # @return [String, Symbol] hash key
      def compose(value)
        @hash.key(value)
      end

      # (see Base#allowed?)
      # @param [Integer] value hash value
      # @return [Boolean]
      def allowed?(value)
        @hash.values.include?(value)
      end

      private

      def check_params
        raise ArgumentError, 'Invalid hash passed' unless @hash.is_a?(Hash)
      end
    end
  end
end
