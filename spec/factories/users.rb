FactoryBot.define do
  factory :user do
    name_first { "Masaya" }
    name_last { "Kaneko" }
    name_user { "MSK" }
    type_user { 1 }
    gender { "man" }
    birthday { "2019-07-13" }
    nationality { "Japanese" }
    country { "Japan" }
    language_first { "Japanese" }
    sequence(:email) { |n| "example#{n}@test.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
