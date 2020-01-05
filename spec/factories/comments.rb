FactoryBot.define do
  factory :comment do
    content { "Test content" }
    association :user
    association :post

    trait :invalid do
      content {}
    end
  end
end
