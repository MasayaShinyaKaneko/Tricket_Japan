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
  end
end
