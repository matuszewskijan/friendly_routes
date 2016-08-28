Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  dummies_route = FriendlyRoutes::Route.new(:get, '/', controller: :dummies, action: :index)
  dummies_route.boolean(:boolean, true: :true_condition, false: :false_condition)
  friendly_url_for dummies_route
  resources :dummies, only: [:index]
end
