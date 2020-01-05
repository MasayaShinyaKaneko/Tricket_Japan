require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    expect(create(:comment)).to be_valid
  end

  describe "validation" do
    context "presence validation" do
      it "is invalid without a content" do
        comment = build(:comment, content: nil)
        expect(comment).to_not be_valid
      end
    end
  end
end
