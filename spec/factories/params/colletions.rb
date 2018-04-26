# frozen_string_literal: true
FactoryBot.define do
  factory :collection, class: FriendlyRoutes::Params::CollectionParams do
    transient do
      items 0
    end
    name { Faker::Lorem.word }
    collection Category
    attribute :title
    optional true

    trait :required do
      optional false
    end

    initialize_with { new(name, collection, attribute, optional: optional) }

    after(:build) do |_collection_param, evaluator|
      create_list(:category, evaluator.items)
    end
  end
end
