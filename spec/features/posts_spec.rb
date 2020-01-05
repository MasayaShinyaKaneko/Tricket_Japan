require 'rails_helper'

RSpec.feature "Posts", type: :feature do

  scenario "user creates a new post" do
    # user = create(:user)
    # visit root_path

    # #調べた書き方
    # find_field('user[email]').set(user.email)
    # find_field('user[password]').set(user.password)
    # find("input[name='commit']").click

    # #テキストの書き方
    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password
    # click_button "Log in"
    # expect {
    #   fill_in "Title", with: "Test Post"
    #   fill_in "Content", with: "Test Post"
    #   fill_in "When", with: "Test time"
    #   fill_in "Where", with: "Test place"
    #   fill_in "Area", with: "area"
    #   fill_in "Season", with: "season"
    #   fill_in "Interest", with: "interest"
    #   click_button "post"
    #   expect(page).to have_content "You have posted the Tricket successfully."
    #   expect(page).to have_content "Test Post"
    # }.to change(user.posts, :count).by(1)



      # find_field('user[email]').set(@user.email)
      # find_field('user[password]').set(@user.password)
      # find("input[name='commit']").click



  end
end
