# frozen_string_literal: true

module FriendlyRoutes
  module Params
    # Created to work with ActiveRecord collection
    #
    # @attr [Object] collection Instance of ActiveRecord collection
    # @attr [Symbol, String] key_attr name of attribute for matching
    class CollectionParams < Base
      attr_accessor :collection, :key_attr

      def initialize(name, collection, key_attr, optional: true)
        super(:collection, name, optional)
        @collection = collection
        @key_attr = key_attr
        check_params
      end

      def constraints
        Regexp.new @collection.all.map(&@key_attr).compact.map(&:downcase).join('|')
      end

      # (see Base#parse)
      # @param [String] value value of item key attr
      # @return [Integer, nil] item id or nil if item not found
      def parse(value)
        @collection.find_by(@key_attr => value).try(:id)
      end

      # (see Base#compose)
      # @param [Integer] id id of collection member
      # @return [String] member key attr
      def compose(id)
        @collection.find(id)[@key_attr]
      end

      private

      def check_params
        if @collection.nil? || @key_attr.nil?
          raise ArgumentError, 'Collection or key attribute not passed'
        end
      end
    end
  end
end
