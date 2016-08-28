require 'friendly_routes/dispatcher'
require 'friendly_routes/helper'
require 'friendly_routes/parser'
require 'friendly_routes/route'

module FriendlyRoutes
end

ActionDispatch::Routing::Mapper.include FriendlyRoutes::Dispatcher
ActiveSupport.on_load(:action_controller) do
  include FriendlyRoutes::Helper
end
