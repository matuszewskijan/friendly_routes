# frozen_string_literal: true

module FriendlyRoutes
  module Helper
    def parse_friendly_routes
      FriendlyRoutes::Parser.new(params).call
    end
  end
end
