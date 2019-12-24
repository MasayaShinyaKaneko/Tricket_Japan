FactoryBot.define do
  factory :contact do
    subject { "Test subject" }
    content { "Test"*8 }
    status_reply { 0 }
    association :user
  end
end
