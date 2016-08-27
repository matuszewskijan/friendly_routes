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
      @params.push(params.merge(type: :boolean, name: name))
    end

    def path
      @original_path + mapped_params
    end

    private

    def mapped_params
      mapped = @params.map do |param|
        ":#{@prefix}_#{param[:name]}"
      end
      mapped.join('/')
    end
  end
end
