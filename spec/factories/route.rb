FactoryGirl.define do
  factory :route, class: FriendlyRoutes::Route do
    transient do
      boolean_conditions 0
    end

    http_method :get
    path '/'
    controller Faker::Hipster.word.pluralize
    action Faker::Hacker.verb

    initialize_with { new(http_method, path, controller: controller, action: action) }

    after(:build) do |route, evaluator|
      evaluator.boolean_conditions.times do
        statements = { true: Faker::Hipster.word, false: Faker::Hipster.word }
        route.boolean(Faker::Hipster.word, statements)
      end
    end
  end
end
