require 'rails_helper'

RSpec.describe Contact, type: :model do

  it "has a valid factory" do
    expect(create(:contact)).to be_valid
  end

  describe "validation" do

    context "presence validation" do
      it "is invalid without a subject" do
        contact = build(:contact, subject: nil)
        expect(contact).to_not be_valid
      end
      it "is invalid without a content" do
        contact = build(:contact, content: nil)
        expect(contact).to_not be_valid
      end
    end

    context "length validation" do
      it "is invalid with subject that has not less than 51 characters" do
        contact = build(:contact, subject: "a"*51)
        expect(contact).to_not be_valid
      end
      it "is valid with subject that has not more than 50 characters" do
        contact = build(:contact, subject: "a"*50)
        expect(contact).to be_valid
      end
      it "is invalid with content that has not less than 501 characters" do
        contact = build(:contact, content: "a"*501)
        expect(contact).to_not be_valid
      end
      it "is valid with content that has not more than 500 characters" do
        contact = build(:contact, content: "a"*500)
        expect(contact).to be_valid
      end
    end
  end
end



