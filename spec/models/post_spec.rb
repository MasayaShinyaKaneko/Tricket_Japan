require 'rails_helper'

RSpec.describe Post, type: :model do

  before do
    @user = User.create(
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
  end

  it "is valid with a title, content, time_todo, place_todo, area, season, interest, status_accomplishment, status_display" do
    # user = User.create(
    #   name_first: "Masaya",
    #   name_last:  "Kaneko",
    #   name_user:  "MSK",
    #   type_user:  1,
    #   gender:     "man",
    #   birthday:   "2019-07-13",
    #   nationality: "Japanese",
    #   country:    "Japan",
    #   language_first:   "Japanese",
    #   email:      "tester@example.com",
    #   password:   "111111",
    # )
    post = @user.posts.build(
      title:      "Test Post",
      content:    "Test content",
      time_todo:  "Test time",
      place_todo: "Test place",
      area:       "area",
      season:     "season",
      interest:   "interest",
    )
    expect(post).to be_valid
  end


  context "presence validation" do
    it "is invalid without a title" do
      post = Post.new(title: nil)
      post.valid?
      expect(post.errors[:title]).to include("can't be blank")
    end
    it "is invalid without a content" do
      post = Post.new(content: nil)
      post.valid?
      expect(post.errors[:content]).to include("can't be blank")
    end
  end

    # it "is invalid without a last name" do
    #   user = User.new(name_last: nil)
    #   user.valid?
    #   expect(user.errors[:name_last]).to include("can't be blank")
    # end

    # it "is invalid without a user name" do
    #   user = User.new(name_user: nil)
    #   user.valid?
    #   expect(user.errors[:name_user]).to include("can't be blank")
    # end

    # it "is invalid without a user type" do
    #   user = User.new(type_user: nil)
    #   user.valid?
    #   expect(user.errors[:type_user]).to include("can't be blank")
    # end

    # it "is invalid without a user gender" do
    #   user = User.new(gender: nil)
    #   user.valid?
    #   expect(user.errors[:gender]).to include("can't be blank")
    # end

    # it "is invalid without a user birthday" do
    #   user = User.new(birthday: nil)
    #   user.valid?
    #   expect(user.errors[:birthday]).to include("can't be blank")
    # end

    # it "is invalid without a user nationality" do
    #   user = User.new(nationality: nil)
    #   user.valid?
    #   expect(user.errors[:nationality]).to include("can't be blank")
    # end









	it "does not allow duplicate post titles per user" do
  #   user = User.create(
  #     name_first: "Masaya",
  #     name_last:  "Kaneko",
  #     name_user:  "MSK",
  #     type_user:  1,
  #     gender:     "man",
  #     birthday:   "2019-07-13",
  #     nationality: "Japanese",
  #     country:    "Japan",
  #     language_first:   "Japanese",
  #     email:      "tester@example.com",
  #     password:   "111111",
		# )
		@user.posts.create(
      title: 		  "Test Post", #validation_check!
      content: 	  "Test content",
      time_todo: 	"Test time",
      place_todo: "Test place",
      area:       "area",
      season: 	  "season",
      interest: 	"interest",
      status_accomplishment: 0,
      status_display: 0,
		)
  		new_post = @user.posts.build(
    	title: 		  "Test Post", #validation_check!
    	content: 	  "Test content",
    	time_todo: 	"Test time",
    	place_todo: "Test place",
    	area:       "area",
  		season: 	  "season",
  		interest: 	"interest",
  		status_accomplishment: 0,
  		status_display: 0,
		)
  	new_post.valid?
  	expect(new_post.errors[:title]).to include("has already been taken")
	end

  it "allows two users to share a post title" do
    # user = User.create(
    #   name_first: "Masaya",
    #   name_last:  "Kaneko",
    #   name_user:  "MSK",
    #   type_user:  1,
    #   gender:     "man",
    #   birthday:   "2019-07-13",
    #   nationality: "Japanese",
    #   country:    "Japan",
    #   language_first:   "Japanese",
    #   email:      "tester@example.com",
    #   password:   "111111",
    # )
    @user.posts.create(
      title:      "Test Post", #validation_check!
      content:    "Test content",
      time_todo:  "Test time",
      place_todo: "Test place",
      area:       "area",
      season:     "season",
      interest:   "interest",
      status_accomplishment: 0,
      status_display: 0,
    )
    other_user = User.create(
      name_first: "Tetsuya",
      name_last:  "Kaneko",
      name_user:  "TK",
      type_user:  1,
      gender:     "man",
      birthday:   "2019-02-11",
      nationality: "Japanese",
      country:    "Japan",
      language_first:   "Japanese",
      email:      "tester@example.com",
      password:   "111111",
    )
    other_post = other_user.posts.build(
      title:      "Test Post", #validation_check!
      content:    "Test content",
      time_todo:  "Test time",
      place_todo: "Test place",
      area:       "area",
      season:     "season",
      interest:   "interest",
      status_accomplishment: 0,
      status_display: 0,
    )
    expect(other_post).to be_valid
  end
end
