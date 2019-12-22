FactoryBot.define do
  factory :post do
    title { "Test Post" }
    content { "Test content" }
    time_todo { "Test time" }
    place_todo { "Test place" }
    area { "area" }
    season { "season" }
    interest { "interest" }
    association :user
  end
end
