# frozen_string_literal: true

module FriendlyRoutes
  module Params
    class Collection < Base
      attr_accessor :collection, :key_attr

      def initialize(name, collection, key_attr)
        super(:collection, name)
        @collection = collection
        @key_attr = key_attr
        check_params
      end

      def constraints
        Regexp.new @collection.all.map(&@key_attr).join('|')
      end

      def parse(value)
        @collection.find_by(@key_attr => value).try(:id)
      end

      private

      def check_params
        unless @collection.try(:has_attribute?, @key_attr)
          raise ArgumentError, "Collection not passed, or doesn't have passed attribute"
        end
      end
    end
  end
end
