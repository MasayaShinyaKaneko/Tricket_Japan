FactoryBot.define do
  factory :favorite do
    association :user
    association :follow
  end
end
