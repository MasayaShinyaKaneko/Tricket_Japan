require 'rails_helper'

RSpec.describe Post, type: :model do

	it "does not allow duplicate post titles per user" do
    	user = User.create(
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
		user.posts.create(
    	  	title: 		"Test Post",
    	  	content: 	"Test content",
    	  	time_todo: 	"Test time",
    	  	place_todo: "Test place",
    	  	area: "area",
      		season: 	"season",
      		interest: 	"interest",
      		status_accomplishment: 0,
      		status_display: 0,
		)
  		new_post = user.posts.build(
    	  	title: 		"Test Post",
    	  	content: 	"Test content",
    	  	time_todo: 	"Test time",
    	  	place_todo: "Test place",
    	  	area: "area",
      		season: 	"season",
      		interest: 	"interest",
      		status_accomplishment: 0,
      		status_display: 0,
		)
  		new_post.valid?
  		expect(new_post.errors[:title]).to include("has already been taken")
	end


# 二人のユーザーが同じ名前を使うことは許可すること it "allows two users to share a project name" do
#   user = User.create(
#     first_name: "Joe",
# 	last_name:  "Tester",
#       email:      "joetester@example.com",
#       password:   "dottle-nouveau-pavilion-tights-furze",
# )
#     user.projects.create(
#       name: "Test Project",
# )
#     other_user = User.create(
#       first_name: "Jane",
#       last_name:  "Tester",
#       email:      "janetester@example.com",
#       password:   "dottle-nouveau-pavilion-tights-furze",
# )
#     other_project = other_user.projects.build(
#       name: "Test Project",
# )
#     expect(other_project).to be_valid

end
