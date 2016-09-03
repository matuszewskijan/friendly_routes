# frozen_string_literal: true

module FriendlyRoutes
  module Dispatcher
    def friendly_url_for(route, method, as: '')
      public_send(
        method,
        route.path,
        controller: route.controller,
        action: route.action,
        friendly_route: route,
        constraints: route.constraints,
        as: as
      )
    end
  end
end
