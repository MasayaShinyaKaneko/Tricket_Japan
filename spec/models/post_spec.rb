require 'rails_helper'

RSpec.describe Post, type: :model do

  it "has a valid factory" do
    expect(create(:post)).to be_valid
  end

  context "presence validation" do
    it "is invalid without a title" do
      post = build(:post, title: nil)
      expect(post).to_not be_valid
    end
    it "is invalid without a content" do
      post = build(:post, content: nil)
      expect(post).to_not be_valid
    end
    it "is invalid without a area" do
      post = build(:post, area: nil)
      expect(post).to_not be_valid
    end
    it "is invalid without a season" do
      post = build(:post, season: nil)
      expect(post).to_not be_valid
    end
    it "is invalid without a interest" do
      post = build(:post, interest: nil)
      expect(post).to_not be_valid
    end
    it "is invalid without a time_todo" do
      post = build(:post, time_todo: nil)
      expect(post).to_not be_valid
    end
    it "is invalid without a place_todo" do
      post = build(:post, place_todo: nil)
      expect(post).to_not be_valid
    end
    it "is invalid without a status_accomplishment" do
      post = build(:post, status_accomplishment: nil)
      expect(post).to_not be_valid
    end
    it "is invalid without a status_display" do
      post = build(:post, status_display: nil)
      expect(post).to_not be_valid
    end
  end

  context "uniqueness validation" do
    it "does not allow duplicate post titles per user" do
      post = create(:post)


    end
  end

 #  		new_post = @user.posts.build(
 #    	title: 		  "Test Post", #validation_check!
 #    	content: 	  "Test content",
 #    	time_todo: 	"Test time",
 #    	place_todo: "Test place",
 #    	area:       "area",
 #  		season: 	  "season",
 #  		interest: 	"interest",
 #  		status_accomplishment: 0,
 #  		status_display: 0,
	# 	)
 #  	new_post.valid?
 #  	expect(new_post.errors[:title]).to include("has already been taken")
	# end



 #  it "allows two users to share a post title" do
 #    # user = User.create(
 #    #   name_first: "Masaya",
 #    #   name_last:  "Kaneko",
 #    #   name_user:  "MSK",
 #    #   type_user:  1,
 #    #   gender:     "man",
 #    #   birthday:   "2019-07-13",
 #    #   nationality: "Japanese",
 #    #   country:    "Japan",
 #    #   language_first:   "Japanese",
 #    #   email:      "tester@example.com",
 #    #   password:   "111111",
 #    # )
 #    @user.posts.create(
 #      title:      "Test Post", #validation_check!
 #      content:    "Test content",
 #      time_todo:  "Test time",
 #      place_todo: "Test place",
 #      area:       "area",
 #      season:     "season",
 #      interest:   "interest",
 #      status_accomplishment: 0,
 #      status_display: 0,
 #    )
 #    other_user = User.create(
 #      name_first: "Tetsuya",
 #      name_last:  "Kaneko",
 #      name_user:  "TK",
 #      type_user:  1,
 #      gender:     "man",
 #      birthday:   "2019-02-11",
 #      nationality: "Japanese",
 #      country:    "Japan",
 #      language_first:   "Japanese",
 #      email:      "tester@example.com",
 #      password:   "111111",
 #    )
 #    other_post = other_user.posts.build(
 #      title:      "Test Post", #validation_check!
 #      content:    "Test content",
 #      time_todo:  "Test time",
 #      place_todo: "Test place",
 #      area:       "area",
 #      season:     "season",
 #      interest:   "interest",
 #      status_accomplishment: 0,
 #      status_display: 0,
 #    )
 #    expect(other_post).to be_valid
 #  end
end
