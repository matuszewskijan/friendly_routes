require 'friendly_routes/route'
require 'friendly_routes/dispatcher'

module FriendlyRoutes
end

ActionDispatch::Routing::Mapper.include FriendlyRoutes::Dispatcher
