# frozen_string_literal: true

module FriendlyRoutes
  module Params
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

      def parse(value)
        @collection.find_by(@key_attr => value).try(:id)
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
