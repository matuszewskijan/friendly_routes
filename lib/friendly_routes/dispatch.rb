# frozen_string_literal: true

module ActionDispatch::Routing
  class Mapper
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

      friendly_route = options.key?(:friendly_route)
      path = Mapping.normalize_path URI::DEFAULT_PARSER.escape(path), formatted, friendly_route
      ast = ::ActionDispatch::Journey::Parser.parse path

      mapping = Mapping.build(@scope, @set, ast, controller, default_action, to, via, formatted, options_constraints, anchor, options)
      @set.add_route(mapping, as)
    end

    def self.normalize_path(path, friendly_route = false)
      path = ::ActionDispatch::Journey::Router::Utils.normalize_path(path)
      # the path for a root URL at this point can be something like
      # "/(/:locale)(/:platform)/(:browser)", and we would want
      # "/(:locale)(/:platform)(/:browser)"

      # reverse "/(", "/((" etc to "(/", "((/" etc
      path.gsub!(%r{/(\(+)/?}, '\1/')
      # if a path is all optional segments, change the leading "(/" back to
      # "/(" so it evaluates to "/" when interpreted with no options.
      # Unless, however, at least one secondary segment consists of a static
      # part, ex. "(/:locale)(/pages/:page)"
      # old_path = path.clone
      # old_path  = path.clone
      path.sub!(%r{^(\(+)/}, '/\1') if %r{^(\(+[^)]+\))(\(+/:[^)]+\))*$}.match?(path) unless friendly_route
      path
    end

    class Mapping
      def self.normalize_path(path, format, friendly_route)
        path = Mapper.normalize_path(path, friendly_route)

        if format == true
          "#{path}.:format"
        elsif optional_format?(path, format)
          "#{path}(.:format)"
        else
          path
        end
      end
    end
  end
end
