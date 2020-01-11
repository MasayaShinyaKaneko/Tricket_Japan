require 'rails_helper'

RSpec.feature "Users", type: :feature do

  feature "user sign up" do
    context "with valid attributes" do
      before do
        visit root_path
        click_link "sign_up1"
        fill_in "first name", with: "Masaya"
        fill_in "last name", with: "Kaneko"
        fill_in "user name", with: "MSK"
        select "man", from: "user_gender"
        select "1991", from: "user_birthday_1i"
        select "July", from: "user_birthday_2i"
        select "13", from: "user_birthday_3i"
        select "Japanese", from: "user_nationality"
        select "Japan", from: "user_country"
        select "Japanese", from: "user_language_first"
        fill_in "user_email", with: "example@test.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
      end
      scenario "sign up" do
        expect {
          click_button "Sign up"
        }.to change(User, :count).by(1)
        # expect(page).to have_current_path user_path(current_user)
        # expect(page).to have_content "successfully"
      end
    end
    context "with invalid attributes" do
      before do
        visit root_path
        click_link "sign_up1"
        fill_in "first name", with: nil
        fill_in "last name", with: "Kaneko"
        fill_in "user name", with: "MSK"
        select "man", from: "user_gender"
        select "1991", from: "user_birthday_1i"
        select "July", from: "user_birthday_2i"
        select "13", from: "user_birthday_3i"
        select "Japanese", from: "user_nationality"
        select "Japan", from: "user_country"
        select "Japanese", from: "user_language_first"
        fill_in "user_email", with: "example@test.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
      end
      scenario "does not sign up" do
        expect(page).to have_current_path new_user_registration_path(type_user: 0)
        # expect(page).to have_content "error"
      end
    end
  end

  feature "user log in" do
    context "with valid attributes" do
      before do
        @user = create(:user)
        visit root_path
      end
      scenario "log in" do
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        click_button "Log in"
        expect(page).to have_current_path posts_top_path
        expect(page).to have_link "out", href: destroy_user_session_path
      end
    end
    context "with invalid attributes" do
      before do
        @user = create(:user)
        visit root_path
      end
      scenario "does not log in" do
        fill_in "email", with: nil
        fill_in "password", with: @user.password
        click_button "Log in"
        expect(page).to have_current_path new_user_session_path
      end
    end
  end
end
