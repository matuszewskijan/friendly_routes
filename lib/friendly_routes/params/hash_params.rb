# frozen_string_literal: true

module FriendlyRoutes
  module Params
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

      def parse(value)
        @hash[value]
      end

      private

      def check_params
        raise ArgumentError, 'Invalid hash passed' unless @hash.is_a?(Hash)
      end
    end
  end
end
