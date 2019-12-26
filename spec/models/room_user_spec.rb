require 'rails_helper'

RSpec.describe RoomUser, type: :model do
  it "has a valid factory" do
    expect(create(:room_user)).to be_valid
  end
end
