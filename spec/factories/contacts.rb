FactoryBot.define do
  factory :contact do
    subject { "Test subject" }
    content { "Test"*8 }
    status_reply { 0 }
    association :user

    trait :too_long_subject do
      subject { "a"*51 }
    end
    trait :short_enough_subject do
      subject { "a"*50 }
    end
    trait :too_long_content do
      content { "a"*501 }
    end
    trait :short_enough_content do
      content { "a"*500 }
    end
  end
end
