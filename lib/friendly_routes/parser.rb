# frozen_string_literal: true

module FriendlyRoutes
  class Parser
    def initialize(params)
      @params = params
      @route = @params[:friendly_route]
    end

    def call
      @route.params.each do |param|
        send(param[:type], param)
      end
    end

    private

    def boolean(param)
      value = @params[@route.prefixed_param_name(param)]
      return unless value
      @params[param[:name]] = value == param[:true]
    end
  end
end
