module FriendlyRoutes
  class Route
    attr_accessor :method, :path, :controller, :action

    def initialize(method, path, controller: nil, action: nil)
      @method = method
      @path = path
      @controller = controller
      @action = action
    end
  end
end
