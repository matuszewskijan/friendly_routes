# frozen_string_literal: true

module FriendlyRoutes
  class PrefixedParams
    def initialize(params, prefix)
      @params = params
      @prefix = prefix
    end

    def call
      mapped.join('/')
    end

    private

    def mapped
      @params.map do |param|
        if param.is_a?(FriendlyRoutes::Params::Base)
          name = PrefixedParam.new(param.name, @prefix).call
          param.optional? ? "(:#{name})" : ":#{name}"
        else
          param
        end
      end
    end
  end
end
