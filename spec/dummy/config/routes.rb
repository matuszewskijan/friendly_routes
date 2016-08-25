Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  friendly_dummies = FriendlyRoutes::Route.new(:get, '/', controller: :dummies, action: :index)
  friendly_url_for friendly_dummies
  resources :dummies, only: [:index]
end
