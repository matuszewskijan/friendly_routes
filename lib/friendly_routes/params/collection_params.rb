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
        @collection_ids = collection.pluck(:id)
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
      # @param [Integer|Object] id_or_instance collection instance or it id
      # @return [String] member key attr
      def compose(id_or_instance)
        instance = id_or_instance
        instance = @collection.find(id_or_instance) unless instance.is_a?(ActiveRecord::Base)
        instance[@key_attr]
      end

      # (see Base#allowed?)
      # @param [Integer|Object] id_or_instance collection instance or it id
      # @return [Boolean]
      def allowed?(id_or_instance)
        if id_or_instance.is_a?(@collection.class)
          @collection_ids.includes?(id_or_instance.id)
        else
          @collection.find_by(id: id_or_instance).present?
        end
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
