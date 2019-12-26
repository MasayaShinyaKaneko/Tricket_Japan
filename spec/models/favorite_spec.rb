require 'rails_helper'

RSpec.describe Favorite, type: :model do

  it "has a valid factory" do
    expect(create(:favorite)).to be_valid
  end

  describe "validation" do

    context "uniqueness validation" do
      before do
        @favorite = create(:favorite)
      end
      it "does not allow duplicate followers per user" do
        favorite = build(:favorite, follow: @favorite.follow, user: @favorite.user)
        expect(favorite).to_not be_valid
      end
      it "allow singular followers per user" do
        favorite = build(:favorite, user: @favorite.user)
        expect(favorite).to be_valid
      end
      it "allows two posts to share a user" do
        favorite = build(:favorite, follow: @favorite.follow)
        expect(favorite).to be_valid
      end
    end
  end
end
