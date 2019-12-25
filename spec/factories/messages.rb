FactoryBot.define do
  factory :message do
    content { "Test content" }
    status_open { 0 }
    association :user
    association :room
  end
end
