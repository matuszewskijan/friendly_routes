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

    # NOTE: We're monkey patching the ActionDispatch::Routing::Mapper#add_route and #normalize_path
    # because Rails 6 broke matching of friendly routes where path consists only of optional parameters
    def add_route(action, controller, options, _path, to, via, formatted, anchor, options_constraints)
      path = path_for_action(action, _path)
      raise ArgumentError, "path is required" if path.blank?

      action = action.to_s

      default_action = options.delete(:action) || @scope[:action]

      if /^[\w\-\/]+$/.match?(action)
        default_action ||= action.tr("-", "_") unless action.include?("/")
      else
        action = nil
      end

      as = if !options.fetch(:as, true) # if it's set to nil or false
        options.delete(:as)
      else
        name_for_action(options.delete(:as), action)
      end

      # Monkey patch start
      friendly_route = options.key?(:friendly_route)
      path = normalize_path URI::DEFAULT_PARSER.escape(path), formatted, friendly_route
      # Monkey patch end

      ast = ::ActionDispatch::Journey::Parser.parse path

      mapping = ::ActionDispatch::Routing::Mapper::Mapping.build(@scope, @set, ast, controller, default_action, to, via, formatted, options_constraints, anchor, options)
      @set.add_route(mapping, as)
    end

    # NOTE: It's combined #normalize_path from
    # ActionDispatch::Routing::Mapper::Mapping and ActionDispatch::Routing::Mapper classes
    def normalize_path(path, format, friendly_route)
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
      path.sub!(%r{^(\(+)/}, '/\1') if %r{^(\(+[^)]+\))(\(+/:[^)]+\))*$}.match?(path) unless friendly_route

      if format == true
        "#{path}.:format"
      elsif ActionDispatch::Routing::Mapper::Mapping.optional_format?(path, format)
        "#{path}(.:format)"
      else
        path
      end
    end
  end
end

