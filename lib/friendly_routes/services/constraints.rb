# frozen_string_literal: true

module FriendlyRoutes
  class Constraints
    def initialize(params, prefix)
      @params = params
      @prefix = prefix
    end

    def call
      @params.map do |param|
        [FriendlyRoutes::PrefixedParam.new(param.name, @prefix).call.to_sym, param.constraints]
      end.to_h
    end
  end
end
