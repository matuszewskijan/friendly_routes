# frozen_string_literal: true
FactoryGirl.define do
  factory :collection, class: FriendlyRoutes::Params::Collection do
    name { Faker::Lorem.word }
    collection { Category }
    attribute { :title }

    initialize_with { new(name, collection, attribute) }
  end
end
