require 'rails_helper'

RSpec.feature "Users", type: :feature do

  before do
    @user_traveler = create(:user, type_user: 0)
    @user_local = create(:user, type_user: 1)
  end

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
      scenario "sign up successfully" do
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
    before do
      visit root_path
    end
    context "with valid attributes" do
      scenario "log in successfully" do
        fill_in "email", with: @user_traveler.email
        fill_in "password", with: @user_traveler.password
        click_button "Log in"
        expect(page).to have_current_path posts_top_path
        expect(page).to have_link "out", href: destroy_user_session_path
      end
    end
    context "with invalid attributes" do
      scenario "does not log in" do
        fill_in "email", with: nil
        fill_in "password", with: @user_traveler.password
        click_button "Log in"
        expect(page).to have_current_path new_user_session_path
      end
    end
  end
  feature "user log out" do
    before do
      visit root_path
      fill_in "email", with: @user_traveler.email
      fill_in "password", with: @user_traveler.password
      click_button "Log in"
      visit user_path(@user_traveler)
    end
    scenario "log out successfully" do
      click_link "out"
      expect(page).to have_current_path root_path
    end
  end
  feature "header links" do
    scenario "when user log in" do
      visit root_path
      fill_in "email", with: @user_traveler.email
      fill_in "password", with: @user_traveler.password
      click_button "Log in"
      expect(page).to have_link "#{@user_traveler.name_user}さん", href: user_path(@user_traveler)
      expect(page).to have_link "Trickets", href: posts_top_path
      expect(page).to have_link "Photos", href: photos_path
      expect(page).to have_link "Locals", href: users_locals_path
      expect(page).to have_link "Notification", href: notifications_path
      expect(page).to have_link "Messages", href: rooms_path
      expect(page).to have_link "Contacts", href: new_contact_path
      expect(page).to have_link "out", href: destroy_user_session_path
    end
    scenario "when user log out" do
      visit root_path
      expect(page).to have_link "Home", href: root_path
    end
  end
  feature "表示内容とリンクの確認" do
    scenario "マイページの表示内容とリンク" do
      visit user_path(@user_local)
        # expect(page).to have_content @user_local.name_user
        expect(page).to have_content "Local"
        expect(page).to have_content "Trickets"
        expect(page).to have_content "Accomplishments"

        # expect(page).to have_content @user1.introduction
        # expect(page).to have_link "",href: edit_user_path(@user1)
        # expect(page).to have_link "",href: user_path(@user2)
        # expect(page).to have_content @user2.name
      # まだまだ終わってない。
    end
  end
end
