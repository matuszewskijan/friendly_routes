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
  end
end

module ActionDispatch::Routing
  class Mapper
    # NOTE: Overwrite ActionDispatch::Routing::Mapper to disable moving slashes in URLs
    # containg only optional parameters(friendly route mounted on root path)
    def self.normalize_path(path)
      path = ::ActionDispatch::Journey::Router::Utils.normalize_path(path)

      # reverse "/(", "/((" etc to "(/", "((/" etc
      path.gsub!(%r{/(\(+)/?}, '\1/')
      # if a path is all optional segments, change the leading "(/" back to
      # "/(" so it evaluates to "/" when interpreted with no options.
      # Unless, however, at least one secondary segment consists of a static
      # part, ex. "(/:locale)(/pages/:page)"
      # old_path = path.clone
      # old_path  = path.clone
      # NOTE: It's not desired behaviour for friendly_routes gem so we're disabling this `sub!` call
      # otherwise paths with all optional parameters won't be properly matched, for example:
      # "/(/:city_id)(/:location_id)"
      path.sub!(%r{^(\(+)/}, '/\1') if %r{^(\(+[^)]+\))(\(+/:[^)]+\))*$}.match?(path) && !path.include?(':friendly_routes')
      path
    end
  end
end

