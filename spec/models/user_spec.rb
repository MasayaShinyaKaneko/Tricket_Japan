require 'rails_helper'

RSpec.describe User, type: :model do
	# 姓、名、ユーザ名、メール、パスワードがあれば有効な状態であること
	it "is valid with a first name, last name, user name, email, and password" do
	    user = User.new(
	      name_first: "Masaya",
	      name_last:  "Kaneko",
	      name_user:  "MSK",
	      email:      "tester@example.com",
	      password:   "111111",
		)
	    expect(user).to be_valid
  	end
	# 名がなければ無効な状態であること
	it "is invalid without a first name" do
  		user = User.new(name_first: nil)
  		user.valid?
  		expect(user.errors[:name_first]).to include("can't be blank")
	end
	# 姓がなければ無効な状態であること
	it "is invalid without a last name"
	# メールアドレスがなければ無効な状態であること
	it "is invalid without an email address"
	# 重複したメールアドレスなら無効な状態であること
	it "is invalid with a duplicate email address"
	# ユーザーのフルネームを文字列として返すこと
	it "returns a user's full name as a string"

end
