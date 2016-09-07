# frozen_string_literal: true

module FriendlyRoutes
  class PrefixedParams
    def initialize(params, prefix)
      @params = params
      @prefix = prefix
    end

    def to_s
      mapped(true).join('/')
    end

    def call
      mapped(false)
    end

    private

    def mapped(keys = true)
      @params.map do |param|
        if param.is_a?(FriendlyRoutes::Params::Base)
          param_name(param, keys)
        else
          param
        end
      end
    end

    def param_name(param, key = true)
      name = PrefixedParam.new(param.name, @prefix).call
      if key
        param.optional? ? "(:#{name})" : ":#{name}"
      else
        name
      end
    end
  end
end
