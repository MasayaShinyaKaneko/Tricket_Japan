require 'rails_helper'

RSpec.describe Like, type: :model do
  it "has a valid factory" do
    expect(create(:like)).to be_valid
  end

  describe "validation" do
    context "uniqueness validation" do
      before do
        @like = create(:like)
      end
      it "does not allow duplicate users per post" do
        like = build(:like, user: @like.user, post: @like.post)
        expect(like).to_not be_valid
      end
      it "allow singular users per post" do
        like = build(:like, post: @like.post)
        expect(like).to be_valid
      end
      it "allows two posts to share a user" do
        like = build(:like, user: @like.user)
        expect(like).to be_valid
      end
    end
  end
end
