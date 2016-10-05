# frozen_string_literal: true

module FriendlyRoutes
  class PrefixedParam
    def initialize(param, prefix)
      @param = param
      @prefix = prefix
    end

    def call
      (@prefix ? "#{@prefix}_#{@param}" : @param).to_sym
    end
  end
end
