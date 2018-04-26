# frozen_string_literal: true

module FriendlyRoutes
  module Dispatcher
    def friendly_url_for(route, method, path, as: '', controller: '', action: '')
      ActiveRecord::Base.establish_connection
      ActiveRecord::Base.connection
    rescue ActiveRecord::NoDatabaseError, PG::ConnectionBad
      warn "Not connected!"
    else
      tables_required = route.params.dup.keep_if do |param|
        param.is_a?(FriendlyRoutes::Params::CollectionParams)
      end.map { |param| param.collection.to_s.tableize }

      tables = tables_required - ActiveRecord::Base.connection.tables

      if tables.present?
        return $stdout << "Tables #{tables.join(", ")} not exists!"
      end

      public_send(
        method,
        path + route.path,
        controller:     controller,
        action:         action,
        friendly_route: route,
        constraints:    route.constraints,
        as:             as
      )
    end
  end
end
