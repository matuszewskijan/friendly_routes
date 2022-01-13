# frozen_string_literal: true

require 'friendly_routes/dispatcher'
require 'friendly_routes/dispatch'
require 'friendly_routes/helper'
require 'friendly_routes/normalization'
require 'friendly_routes/route'
require 'friendly_routes/params/base'
require 'friendly_routes/params/boolean_params'
require 'friendly_routes/params/collection_params'
require 'friendly_routes/params/hash_params'
require 'friendly_routes/services/composer'
require 'friendly_routes/services/constraints'
require 'friendly_routes/services/multi_composer'
require 'friendly_routes/services/parser'
require 'friendly_routes/services/prefixed_param'
require 'friendly_routes/services/prefixed_params'

module FriendlyRoutes
end

ActionDispatch::Routing::Mapper.include FriendlyRoutes::Dispatcher
ActionDispatch::Routing::RouteSet::Generator.prepend FriendlyRoutes::Normalization
ActiveSupport.on_load(:action_controller) do
  include FriendlyRoutes::Helper
end
