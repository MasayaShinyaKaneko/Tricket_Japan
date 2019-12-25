require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it "has a valid factory" do
    expect(create(:favorite)).to be_valid
  end
end
