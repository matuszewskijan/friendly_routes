# frozen_string_literal: true

module FriendlyRoutes
  # Compoer will map passed params to friendly_route params
  class Composer
    def initialize(route, params = {})
      @route = route
      @params = params.dup
    end

    def call
      return unless @route
      @route.dynamic_params.each do |param|
        compose(param)
      end
      @params
    end

    def can_be_composed?
      return unless @route
      @route.required_params.all? do |param|
        param.allowed? @params[param.name]
      end
    end

    private

    def compose(param)
      value = @params[param.name]
      return if value.nil? || param.refused?(value)
      prefixed_name = FriendlyRoutes::PrefixedParam.new(param.name, @route.prefix).call
      @params[prefixed_name] = param.compose(value)
      @params.delete(param.name) unless param.name == prefixed_name
    end
  end
end
