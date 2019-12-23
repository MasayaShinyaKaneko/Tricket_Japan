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
    before do
      post = create(:post, title: "Test Post")
    end
# ユーザを合わせる？
    it "does not allow duplicate post titles per user" do
      post = build(:post, title: "Test Post")
      expect(post).to_not be_valid
    end
    it "does not allow singular post titles per user" do
      post = build(:post, title: "Test Post2")
      expect(post).to be_valid
    end
# もう一人のユーザをどうやって作る？
    it "allows two users to share a post title" do
      post = build(:post, title: "Test Post")
      expect(post).to be_valid
    end
  end
end
