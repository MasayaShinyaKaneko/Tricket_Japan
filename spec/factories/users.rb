FactoryBot.define do
  factory :user, aliases: [:follow] do
    name_first { "Masaya" }
    name_last { "Kaneko" }
    sequence(:name_user) {  |n| "MSK#{n}" }
    gender { "man" }
    birthday { "2019-07-13" }
    nationality { "Japanese" }
    country { "Japan" }
    language_first { "Japanese" }
    sequence(:email) { |n| "example#{n}@test.com" }
    password { "password" }
    password_confirmation { "password" }

    trait :too_long_first_name do
      name_first { "a"*21 }
    end
    trait :short_enough_first_name do
      name_first { "a"*20 }
    end
    trait :too_long_last_name do
      name_last { "a"*21 }
    end
    trait :short_enough_last_name do
      name_last { "a"*20 }
    end
    trait :too_short_password do
      password { "a"*5 }
      password_confirmation { "a"*5 }
    end
    trait :long_enough_password do
      password { "a"*6 }
      password_confirmation { "a"*6 }
    end
    trait :different_password_confirmation do
      password { "a"*6 }
      password_confirmation { "b"*6 }
    end
  end
end
