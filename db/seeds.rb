# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Nationality.create!(
  [
    {
      nationality: "Japanese",
    },
    {
      nationality: "American",
    },
  ]
)

Country.create!(
  [
    {
      country: "other",
    },
    {
      country: "Japan",
    },
    {
      country: "America",
    },
  ]
)

Interest.create!(
  [
    {
      interest: "Nature",
    },
    {
      interest: "Food",
    },
  ]
)

User.create!(
  [
    {
      name_first: "Masaya",
      name_last: "Kaneko",
      name_user: "MSK0713",
      gender: "man",
	  type_user: "1",
      birthday: "19910713",
      nationality_id: "1",
      country_id: "2",
      place_prefecture: "Shizuoka",
      language_first: "Japanese",
      language_second: "English",
      language_third: "Korea",
      picture_profile_id:  "",
      picture_background_id: "",
      hobby:  "Awa-odori(Japanese traditional dance), travel",
      introduction: "Hello, everyone. I'm always happy to support you. Do not hegitate to message me",
      status_user: "0",
      delete_flag: "0",
      email: "test1@gmail.com",
      password:  "111111",
    },
    {
      name_first: "Alexander",
      name_last: "Stewart",
      name_user: "AS",
      gender: "man",
	  type_user: "0",
      birthday: "20000101",
      nationality_id: "2",
      country_id: "3",
      place_prefecture: "",
      language_first: "English",
      language_second: "",
      language_third: "",
      picture_profile_id:  "",
      picture_background_id: "",
      hobby:  "singing & creating songs",
      introduction: "Hello, everyone. I'm a professional singer. I'm excited everytime I visit Japan",
      status_user: "1",
      delete_flag: "0",
      email: "test2@gmail.com",
      password:  "222222",
    }
  ]
)

Post.create!(
  [
    {
      title: "traveling to Yakushima",
      content: "Next year, in 2020, I and my friends would love to visit Yakushima, and hike in nature. Do you have any recommendation?",
      post_image_id: "",
	  user_id: "2",
      area: "Kyushu",
      season: "Automn",
      interest_id: "1",
      time_todo: "In 2020",
      place_todo: "Yakushima",
      status_accomplishment: "0",
      status_display: "0",
      delete_flag:  "0",
      comment_accomplishment: "",
      image_accomplishment_id:  "",
    },
    {
      title: "any restaurant to recommend in Tokyo",
      content: "I've been traveling around Tokyo for 2 weeks and tomorrow is the last day to stay in Japan. Do you have any idea for the last dinner?",
      post_image_id: "",
	  user_id: "2",
      area: "Kansai",
      season: "Summer",
      interest_id: "2",
      time_todo: "tomorrow",
      place_todo: "Tokyo",
      status_accomplishment: "0",
      status_display: "0",
      delete_flag:  "0",
      comment_accomplishment: "",
      image_accomplishment_id:  "",
    }
  ]
)






