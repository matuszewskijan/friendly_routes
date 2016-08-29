# frozen_string_literal: true

module FriendlyRoutes
  module Dispatcher
    def friendly_url_for(route)
      public_send(
        route.method,
        route.path,
        controller: route.controller,
        action: route.action,
        friendly_route: route,
        constraints: route.constraints,
        as: route.as
      )
    end
  end
end
