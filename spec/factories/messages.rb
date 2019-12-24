FactoryBot.define do
  factory :message do
    content { "Test content" }
    association :user
    association :room
  end
end
