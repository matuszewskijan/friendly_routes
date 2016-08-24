module FriendlyRoutes
  class Route
    attr_accessor :method, :path, :controller, :action

    def initialize(method, path, to)
      @method = method
      @path = path
      controller_name, @action = to.split('#')
      @controller = controller_class(controller_name)
    end

    private

    def controller_class(name)
      name.capitalize.concat('Controller').constantize
    end
  end
end
