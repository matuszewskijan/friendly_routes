# frozen_string_literal: true

module FriendlyRoutes
  module Dispatcher
    def friendly_url_for(route, method, path, as: '', controller: '', action: '')
      public_send(
        method,
        path + route.path,
        controller: controller,
        action: action,
        friendly_route: route,
        constraints: route.constraints,
        as: as
      )
    end
  end
end
