require 'rails_helper'

RSpec.describe Message, type: :model do

  it "has a valid factory" do
    expect(create(:message)).to be_valid
  end

  describe "validation" do

    context "presence validation" do
      it "is invalid without a content" do
        contact = build(:message, content: nil)
        expect(contact).to_not be_valid
      end
    end
  end
end
