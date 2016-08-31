FactoryGirl.define do
  factory :route, class: FriendlyRoutes::Route do
    transient do
      boolean_params 0
      collection_items 3
    end
    trait :with_category do
      after(:build) do |route, evaluator|
        create_list(:category, evaluator.collection_items)
        route.collection(Faker::Lorem.word, Category, :title)
      end
    end

    http_method :get
    path '/'
    controller Faker::Hipster.word.pluralize
    action Faker::Hacker.verb

    initialize_with { new(http_method, path, controller: controller, action: action) }

    after(:build) do |route, evaluator|
      evaluator.boolean_params.times do
        statements = { true: Faker::Lorem.word, false: Faker::Lorem.word }
        route.boolean(Faker::Lorem.word, statements)
      end
    end
  end
end
