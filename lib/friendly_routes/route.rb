# frozen_string_literal: true

module FriendlyRoutes
  class Route
    attr_accessor :method, :controller, :action, :params, :prefix

    def initialize(path, controller: nil, action: nil, prefix: 'friendly_routes')
      @original_path = path
      @controller = controller
      @action = action
      @params = []
      @prefix = prefix
    end

    def path
      @original_path + FriendlyRoutes::PrefixedParams.new(@params, @prefix).call
    end

    def as
      "#{@prefix}_#{@controller}_#{@action}"
    end

    def constraints
      FriendlyRoutes::Constraints.new(dynamic_params, @prefix).call
    end

    def dynamic_params
      @params.select { |param| param.is_a?(FriendlyRoutes::Params::Base) }
    end
  end
end
