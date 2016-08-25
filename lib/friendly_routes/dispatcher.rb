module FriendlyRoutes
  module Dispatcher
    def friendly_url_for(route)
      public_send(
        route.method,
        route.path,
        controller: route.controller,
        action: route.action
      )
    end
  end
end
