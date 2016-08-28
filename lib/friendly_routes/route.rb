# frozen_string_literal: true

module FriendlyRoutes
  class Route
    attr_accessor :method, :controller, :action, :params, :prefix

    def initialize(method, path, controller: nil, action: nil, prefix: 'friendly_routes')
      @method = method
      @original_path = path
      @controller = controller
      @action = action
      @params = []
      @prefix = prefix
    end

    def boolean(name, params)
      condition_passed = params[:true] && params[:false]
      raise ArgumentError, 'True and false params is required' unless condition_passed
      @params.push(params.merge(type: :boolean, name: name))
    end

    def path
      @original_path + mapped_params
    end

    def prefixed_param_name(param)
      "#{@prefix}_#{param[:name]}"
    end

    def as
      "#{@prefix}_#{@controller}_#{@action}"
    end

    private

    def mapped_params
      mapped = @params.map do |param|
        ':' + prefixed_param_name(param)
      end
      mapped.join('/')
    end
  end
end
