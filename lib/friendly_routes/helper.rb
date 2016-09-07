# frozen_string_literal: true

module FriendlyRoutes
  module Helper
    def parse_friendly_routes(keep_all: false)
      FriendlyRoutes::Parser.new(params, keep_all).call
    end
  end
end
