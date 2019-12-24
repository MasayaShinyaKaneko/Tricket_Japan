require 'rails_helper'

RSpec.describe Room, type: :model do
  it "has a valid factory" do
    expect(create(:room)).to be_valid
  end
end
