# frozen_string_literal: true
FactoryBot.define do
  factory :boolean, class: FriendlyRoutes::Params::BooleanParams do
    statements { Faker::Lorem.words(2) }

    name { Faker::Lorem.word }

    optional true
    trait :required do
      optional false
    end

    initialize_with do
      new(name, { true: statements.first, false: statements.last }, optional: optional)
    end
  end
end
