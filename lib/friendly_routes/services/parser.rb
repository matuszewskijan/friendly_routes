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
      prefixed_name = FriendlyRoutes::PrefixedParam.new(param.name, @route.prefix).call
      value = @params[prefixed_name]
      return unless value
      @params[param.name] = param.parse(value)
      @params.delete(prefixed_name)
    end
  end
end
