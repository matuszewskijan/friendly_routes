# frozen_string_literal: true
FactoryGirl.define do
  factory :boolean, class: FriendlyRoutes::Params::BooleanParams do
    statements { Faker::Lorem.words(2) }

    name { Faker::Lorem.word }

    initialize_with { new(name, true: statements.first, false: statements.last) }
  end
end
