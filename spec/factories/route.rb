FactoryGirl.define do
  factory :route, class: FriendlyRoutes::Route do
    transient do
      boolean_params 0
      collection_items 3
    end
    trait :with_category do
      after(:build) do |route, evaluator|
        create_list(:category, evaluator.collection_items)
        route.params.push(build(:collection))
      end
    end

    path '/'
    controller Faker::Hipster.word.pluralize
    action Faker::Hacker.verb

    initialize_with { new(path, controller: controller, action: action) }

    after(:build) do |route, evaluator|
      route.params.concat build_list(:boolean, evaluator.boolean_params)
    end
  end
end
