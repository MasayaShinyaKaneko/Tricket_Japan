require 'rails_helper'

RSpec.feature "Users", type: :feature do

  feature "user log in" do
    before do
      @user = create(:user)
      visit root_path
    end
    scenario "with valid attributes" do
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      click_button "Log in"
      expect(page).to have_current_path posts_top_path
    end
  end
end
