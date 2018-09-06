class FriendlyController < ApplicationController
  before_action :parse_friendly_routes

  def index
    @path = url_for(params.to_unsafe_h.merge(only_path: true))
    @new_action_path = url_for(params.to_unsafe_h.merge(action: 'new', only_path: true))
  end

  def new
  end
end
