# frozen_string_literal: true

module FriendlyRoutes
  # == FriendlyRoutes Normalization
  #
  # Normalization options passed to url_for().
  #
  # url_for() use ActionDispatch::Routing::RouteSet::Generator so we add
  # additionally normalization for initialize method of this class.
  #
  # If friendly_route present we move friendly params from recall to options
  # and remove corresponding non-friendly params from options.
  module Normalization
    def initialize(*options)
      super

      return unless friendly_route = @recall[:friendly_route]

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
