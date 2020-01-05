FactoryBot.define do
  password = Faker::Lorem.characters(number: 6)
  too_short_password = Faker::Lorem.characters(number: 5)
  different_password = Faker::Lorem.characters(number: 6)

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
    password { password }
    password_confirmation { password }

    trait :too_long_first_name do
      name_first { Faker::Lorem.characters(number: 21) }
    end
    trait :short_enough_first_name do
      name_first { Faker::Lorem.characters(number: 20) }
    end
    trait :too_long_last_name do
      name_last { Faker::Lorem.characters(number: 21) }
    end
    trait :short_enough_last_name do
      name_last { Faker::Lorem.characters(number: 20) }
    end
    trait :too_short_password do
      password { too_short_password }
      password_confirmation { too_short_password }
    end
    trait :long_enough_password do
      password { password }
      password_confirmation { password }
    end
    trait :different_password_confirmation do
      password { password }
      password_confirmation { different_password }
    end
  end
end
