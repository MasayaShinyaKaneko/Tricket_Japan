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
  end
end
