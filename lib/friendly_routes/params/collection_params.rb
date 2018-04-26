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
        Regexp.new klass.all.map(&@key_attr).compact.map(&:downcase).join('|')
      end

      # (see Base#parse)
      # @param [String] value value of item key attr
      # @return [Integer, nil] item id or nil if item not found
      def parse(value)
        klass.find_by(@key_attr => value).try(:id)
      end

      # (see Base#compose)
      # @param [Integer|Object] id_or_instance collection instance or it id
      # @return [String] member key attr
      def compose(id_or_instance)
        instance = id_or_instance
        instance = klass.find(id_or_instance) unless instance.is_a?(ActiveRecord::Base)
        instance[@key_attr]
      end

      # (see Base#allowed?)
      # @param [Integer|Object] id_or_instance collection instance or it id
      # @return [Boolean]
      def allowed?(id_or_instance)
        if id_or_instance.is_a?(ActiveRecord::Base)
          @collection_ids ||= collection.pluck(:id)
          @collection_ids.include?(id_or_instance.id)
        else
          klass.find_by(id: id_or_instance).present?
        end
      end

      private

      def klass
        @klass ||= @collection.to_s.camelize.constantize
      end

      def check_params
        message = nil
        message = if @collection.nil? || @key_attr.nil?
                    'Collection or key attribute not passed'
                  elsif !@collection.respond_to?(:to_s)
                    'Collection should respond to :to_s'
                  end
        raise(ArgumentError, message) if message
      end
    end
  end
end
