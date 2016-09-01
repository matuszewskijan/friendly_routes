# frozen_string_literal: true

module FriendlyRoutes
  class Parser
    def initialize(params)
      @params = params
      @route = @params[:friendly_route]
    end

    def call
      return unless @route
      @route.params.each do |param|
        parse(param)
      end
    end

    private

    def parse(param)
      value = @params[@route.prefixed_param_name(param)]
      return unless value
      @params[param.name] = param.parse(value)
    end
  end
end
