# frozen_string_literal: true

module FriendlyRoutes
  module Dispatcher
    def friendly_url_for(route, method, as: '', controller: '', action: '')
      public_send(
        method,
        route.path,
        controller: controller,
        action: action,
        friendly_route: route,
        constraints: route.constraints,
        as: as
      )
    end
  end
end
