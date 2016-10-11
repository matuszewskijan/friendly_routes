# frozen_string_literal: true

module FriendlyRoutes
  class Parser
    def initialize(params, keep_all)
      @params = params
      @keep_all = keep_all
      @route = @params[:friendly_route]
    end

    def call
      return unless @route
      @route.dynamic_params.each do |param|
        parse(param)
      end
    end

    private

    def parse(param)
      prefixed_name = FriendlyRoutes::PrefixedParam.new(param.name, @route.prefix).call
      value = @params[prefixed_name]
      return unless value
      @params[param.name] = param.parse(value)
      unless @keep_all
        @params.delete(prefixed_name) unless param.name == prefixed_name
        @params.delete(:friendly_route)
      end
    end
  end
end
