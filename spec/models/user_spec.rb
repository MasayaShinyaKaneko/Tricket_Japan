require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  describe "validation" do

    context "presence validation" do
    	it "is invalid without a first name" do
        user = build(:user, name_first: nil)
        expect(user).to_not be_valid
    	end
    	it "is invalid without a last name" do
        user = build(:user, name_last: nil)
        expect(user).to_not be_valid
      end
      it "is invalid without a user name" do
        user = build(:user, name_user: nil)
        expect(user).to_not be_valid
      end
      it "is invalid without a user type" do
        user = build(:user, type_user: nil)
        expect(user).to_not be_valid
      end
      it "is invalid without a user gender" do
        user = build(:user, gender: nil)
        expect(user).to_not be_valid
      end
      it "is invalid without a user birthday" do
        user = build(:user, birthday: nil)
        expect(user).to_not be_valid
      end
      it "is invalid without a user nationality" do
        user = build(:user, nationality: nil)
        expect(user).to_not be_valid
      end
      it "is invalid without a user country" do
        user = build(:user, country: nil)
        expect(user).to_not be_valid
      end
      it "is invalid without a user first language" do
        user = build(:user, language_first: nil)
        expect(user).to_not be_valid
      end
    	it "is invalid without an email address" do
        user = build(:user, email: nil)
        expect(user).to_not be_valid
      end
    	it "is invalid without a password" do
        user = build(:user, password: nil)
        expect(user).to_not be_valid
      end
    end

#uniquenessのテストはこれで合ってる？
    context "uniquness validation" do
      before do
        user = create(:user, email: "example@test.com", name_user: "MSK")
      end
      it "is invalid with a duplicate email address" do
        user = build(:user, email: "example@test.com", name_user: "MSK2")
        expect(user).to_not be_valid
      end
      it "is valid with a singular email address" do
        user = build(:user, email: "example2@test.com", name_user: "MSK2")
        expect(user).to be_valid
      end
      it "is invalid with a duplicate user name" do
        user = build(:user, email: "example2@test.com", name_user: "MSK")
        expect(user).to_not be_valid
      end
      it "is valid with a singular user name" do
        user = build(:user, email: "example2@test.com", name_user: "MSK2")
        expect(user).to be_valid
      end
    end

    context "length validation" do
      it "is invalid with first name that has not less than 21 characters" do
        user = build(:user, name_first: "a"*21)
        expect(user).to_not be_valid
      end
      it "is valid with first name that has not more than 20 characters" do
        user = build(:user, name_first: "a"*20)
        expect(user).to be_valid
      end
      it "is invalid with last name that has not less than 21 characters" do
        user = build(:user, name_last: "a"*21)
        expect(user).to_not be_valid
      end
      it "is valid with last name that has not more than 20 characters" do
        user = build(:user, name_last: "a"*20)
        expect(user).to be_valid
      end
      it "is invalid with password that has not more than 5 characters" do
        user = build(:user, password: "a"*5, password_confirmation: "a"*5)
        expect(user).to_not be_valid
      end
      it "is valid with password that has not less than 6 characters" do
        user = build(:user, password: "a"*6, password_confirmation: "a"*6)
        expect(user).to be_valid
      end
    end

    context "other validation" do
      it "is invalid with password that has different confirmaiton" do
        user = build(:user, password: "a"*6, password_confirmation: "b"*6)
        expect(user).to_not be_valid
      end
    end
  end
end
