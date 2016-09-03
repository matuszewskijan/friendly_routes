# frozen_string_literal: true

require 'friendly_routes/dispatcher'
require 'friendly_routes/helper'
require 'friendly_routes/route'
require 'friendly_routes/params/base'
require 'friendly_routes/params/boolean'
require 'friendly_routes/params/collection'
require 'friendly_routes/services/constraints'
require 'friendly_routes/services/parser'
require 'friendly_routes/services/prefixed_param'
require 'friendly_routes/services/prefixed_params'

module FriendlyRoutes
end

ActionDispatch::Routing::Mapper.include FriendlyRoutes::Dispatcher
ActiveSupport.on_load(:action_controller) do
  include FriendlyRoutes::Helper
end
