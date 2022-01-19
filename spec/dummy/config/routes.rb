include FriendlyRoutes::Params

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dummies, only: [:index]

  def male
    BooleanParams.new(:male, { true: 'male', false: 'female' }, optional: false)
  end

  def category
    CollectionParams.new(:category_id, :category, :title)
  end

  def optional_male
    BooleanParams.new(:male, { true: 'male', false: 'female' }, optional: true)
  end

  def optional_category
    CollectionParams.new(:category_id, :category, :title, optional: true)
  end

  friendly_url_for FriendlyRoutes::Route.new([male, category]),
                   :get, "/", controller: :friendly, action: :index, as: :friendly

  friendly_url_for FriendlyRoutes::Route.new([optional_male, optional_category]),
                   :get, "/", controller: :friendly, action: :index, as: :all_optional_friendly

  resources :friendly, only: :new
end
