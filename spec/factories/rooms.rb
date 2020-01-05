FactoryBot.define do
  factory :room do
    trait :with_messages do
      after(:create) { |room| create_list(:message, 5, room: room) }
    end
  end
end
