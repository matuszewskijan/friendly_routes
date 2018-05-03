class FriendlyController < ApplicationController
  before_action :parse_friendly_routes

  def index
    @path = url_for(params.to_unsafe_h.merge(only_path: true))
  end
end
