require 'rails_helper'

RSpec.describe User, type: :model do

	it "is valid with a first name, last name, user name, user type, gender, birthday, nationality, country, first language, email, and password" do
    user = User.new(
      name_first: "Masaya",
      name_last:  "Kaneko",
      name_user:  "MSK",
      type_user:  1,
      gender:     "man",
      birthday:   "2019-07-13",
      nationality: "Japanese",
      country:   "Japan",
      language_first:   "Japanese",
      email:      "tester@example.com",
      password:   "111111",
    )
    expect(user).to be_valid
  end

	it "is invalid without a first name" do
		user = User.new(name_first: nil)
		user.valid?
		expect(user.errors[:name_first]).to include("can't be blank")
	end

	it "is invalid without a last name" do
  	user = User.new(name_last: nil)
		user.valid?
		expect(user.errors[:name_last]).to include("can't be blank")
  end

  it "is invalid without a user name" do
  	user = User.new(name_user: nil)
		user.valid?
		expect(user.errors[:name_user]).to include("can't be blank")
  end

  it "is invalid without a user type" do
  	user = User.new(type_user: nil)
		user.valid?
		expect(user.errors[:type_user]).to include("can't be blank")
  end

  it "is invalid without a user gender" do
  	user = User.new(gender: nil)
		user.valid?
		expect(user.errors[:gender]).to include("can't be blank")
  end

  it "is invalid without a user birthday" do
  	user = User.new(birthday: nil)
		user.valid?
		expect(user.errors[:birthday]).to include("can't be blank")
  end

  it "is invalid without a user nationality" do
  	user = User.new(nationality: nil)
		user.valid?
		expect(user.errors[:nationality]).to include("can't be blank")
  end

  it "is invalid without a user country" do
  	user = User.new(country: nil)
		user.valid?
		expect(user.errors[:country]).to include("can't be blank")
  end

  it "is invalid without a user first language" do
  	user = User.new(language_first: nil)
		user.valid?
		expect(user.errors[:language_first]).to include("can't be blank")
  end

	it "is invalid without an email address" do
  	user = User.new(email: nil)
		user.valid?
		expect(user.errors[:email]).to include("can't be blank")
  end

	it "is invalid without a password" do
  	user = User.new(password: nil)
		user.valid?
		expect(user.errors[:password]).to include("can't be blank")
  end

	it "is invalid with a duplicate email address" do
		User.create(
      name_first: "Masaya",
      name_last:  "Kaneko",
      name_user:  "MSK",
      type_user:  1,
      gender:     "man",
      birthday:   "2019-07-13",
      nationality: "Japanese",
      country:    "Japan",
      language_first:     "Japanese",
      language_second:    "English",
      language_third:  	  "French",
      picture_profile:    " ",
      picture_background: " ",
      hobby:    	  	  	"hobby",
      introduction:   	"introduction",
      status_user:        0,
      deleted_at:         nil,
      email:      "tester@example.com",
      password:   "111111",
		)
		user = User.new(
      name_first: "Masaya",
      name_last:  "Kaneko",
      name_user:  "MSK",
      type_user:  1,
      gender:     "man",
      birthday:   "2019-07-13",
      nationality: "Japanese",
      country:    "Japan",
      language_first:   "Japanese",
      email:      "tester@example.com",
      password:   "111111",
		)
		user.valid?
		expect(user.errors[:email]).to include("has already been taken")
  end

	# ユーザーのフルネームを文字列として返すこと
	it "returns a user's full name as a string"

end
