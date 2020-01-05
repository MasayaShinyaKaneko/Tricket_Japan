FactoryBot.define do
  factory :comment do
    content { "Test content" }
    association :user
    association :post
  end
end
