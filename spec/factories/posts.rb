require 'faker'

FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Test Post#{n}" }
    content { "Test content" }
    time_todo { "Test time" }
    place_todo { "Test place" }
    area { "area" }
    season { "season" }
    interest { "interest" }
    association :user

    trait :invalid do
      title {}
    end

    trait :too_long_title do
      title { Faker::Lorem.characters(number: 51) }
    end
    trait :short_enough_title do
      title { Faker::Lorem.characters(number: 50) }
    end
    trait :too_long_content do
      content { Faker::Lorem.characters(number: 501) }
    end
    trait :short_enough_content do
      content { Faker::Lorem.characters(number: 500) }
    end
    trait :too_long_time_todo do
      time_todo { Faker::Lorem.characters(number: 51) }
    end
    trait :short_enough_time_todo do
      time_todo { Faker::Lorem.characters(number: 50) }
    end
    trait :too_long_place_todo do
      place_todo { Faker::Lorem.characters(number: 51) }
    end
    trait :short_enough_place_todo do
      place_todo { Faker::Lorem.characters(number: 50) }
    end
  end
end