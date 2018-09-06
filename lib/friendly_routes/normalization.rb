# frozen_string_literal: true

module FriendlyRoutes
  # == FriendlyRoutes Normalization
  #
  # Normalization options passed to url_for().
  #
  # url_for() use ActionDispatch::Routing::RouteSet::Generator so we add
  # additionally normalization for initialize method of this class.
  #
  # If friendly_route present and controller with action is same, we move
  # friendly params from recall to options then remove corresponding
  # non-friendly params from options.
  module Normalization
    def initialize(*options)
      super

      if friendly_route = @recall[:friendly_route]
        recall_controller_action = @recall&.slice(:controller, :action)
        options_controller_action = @options&.slice(:controller, :action)
        return unless recall_controller_action == options_controller_action

        friendly_route.params.each do |param|
          param          = param.name
          prefix         = friendly_route.prefix
          prefixed_param = FriendlyRoutes::PrefixedParam.new(param, prefix)

          use_recall_for(prefixed_param.call)
          @options.delete(param)
        end
      end
    end
  end
end
