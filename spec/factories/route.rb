FactoryBot.define do
  factory :route, class: FriendlyRoutes::Route do
    transient do
      boolean_params 0
    end
    params []

    after(:build) do |route, evaluator|
      route.params.concat build_list(:boolean, evaluator.boolean_params)
    end
    initialize_with { new(params) }
  end
end
