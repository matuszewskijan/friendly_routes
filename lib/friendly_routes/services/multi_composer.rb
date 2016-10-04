# frozen_string_literal: true

module FriendlyRoutes
  # Compoer will map passed params to friendly_route params
  class MultiComposer
    attr_reader :matched_route

    def initialize(routes, params = {})
      @routes = routes
      @params = params.dup
    end

    def call
      compose unless @composed_params
      @composed_params
    end

    private

    def compose
      @routes.each do |route|
        composer = Composer.new(route, @params)
        next unless composer.can_be_composed?
        @matched_route = route
        @composed_params = composer.call
        break
      end
    end
  end
end
