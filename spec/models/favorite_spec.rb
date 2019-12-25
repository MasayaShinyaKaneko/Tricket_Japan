require 'rails_helper'

RSpec.describe Favorite, type: :model do

  it "has a valid factory" do
    expect(create(:favorite, follow_id: 1)).to be_valid
  end

  describe "validation" do
    context "presence validation" do
      it "is invalid without a follow_id" do
        favorite = build(:favorite, follow_id: 1)
        expect(favorite).to_not be_valid
      end
    end
  end
end
