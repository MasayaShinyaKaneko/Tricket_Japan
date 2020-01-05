require 'rails_helper'

RSpec.describe Post, type: :model do
  it "has a valid factory" do
    expect(create(:post)).to be_valid
  end

  describe "validation" do
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
      before do
        @post = create(:post, title: "Test Post")
      end
      it "does not allow duplicate post titles per user" do
        post = build(:post, title: "Test Post", user: @post.user)
        expect(post).to_not be_valid
      end
      it "allow singular post titles per user" do
        post = build(:post, title: "Test Post2")
        expect(post).to be_valid
      end
      it "allows two users to share a post title" do
        post = build(:post, title: "Test Post")
        expect(post).to be_valid
      end
    end
    context "length validation" do
      it "is invalid with title that has not less than 51 characters" do
        post = build(:post, :too_long_title)
        expect(post).to_not be_valid
      end
      it "is valid with title that has not more than 50 characters" do
        post = build(:post, :short_enough_title)
        expect(post).to be_valid
      end
      it "is invalid with content that has not less than 501 characters" do
        post = build(:post, :too_long_content)
        expect(post).to_not be_valid
      end
      it "is valid with content that has not more than 500 characters" do
        post = build(:post, :short_enough_content)
        expect(post).to be_valid
      end
      it "is invalid with time_todo that has not less than 51 characters" do
        post = build(:post, :too_long_time_todo)
        expect(post).to_not be_valid
      end
      it "is valid with time_todo that has not more than 50 characters" do
        post = build(:post, :short_enough_time_todo)
        expect(post).to be_valid
      end
      it "is invalid with place_todo that has not less than 51 characters" do
        post = build(:post, :too_long_place_todo)
        expect(post).to_not be_valid
      end
      it "is valid with place_todo that has not more than 50 characters" do
        post = build(:post, :short_enough_place_todo)
        expect(post).to be_valid
      end
    end
  end
end
