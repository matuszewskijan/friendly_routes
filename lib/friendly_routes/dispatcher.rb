# frozen_string_literal: true

module FriendlyRoutes
  module Dispatcher
    def friendly_url_for(route, method, path, as: '', controller: '', action: '')
      unless ActiveRecord::Base.connected?
        ActiveRecord::Base.establish_connection
        ActiveRecord::Base.connection
      end
    rescue ActiveRecord::NoDatabaseError, PG::ConnectionBad
      puts "FriendlyRoutes: Not connected"
    else
      tables_required = route.params.dup.keep_if do |param|
        param.is_a?(FriendlyRoutes::Params::CollectionParams)
      end.map { |param| param.collection.to_s.tableize }

      tables = tables_required - ActiveRecord::Base.connection.tables

      if tables.present?
        return puts "FriendlyRoutes: Tables #{tables.join(", ")} not exists"
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

    def normalize_path(path)
      # To properly map Friendly Routes with all optional arguments
      # reverse "/(", "/((" etc. to "(/", "((/" etc. to "(/", "(//" etc.
      path = super(path)
      path.gsub!(%r{/(\(+)/?}, '\1/') if path.include?(':friendly')
      path
    end
  end
end
