require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  describe"POST #create" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        @other_user = create(:user)
        sign_in @user
      end
      it "adds a favorite to a user" do
        expect {
          post :create, xhr: true, params: { follow_id: @other_user.id }
        }.to change(@other_user.followers, :count).by(1)
      end
    end
  end
  describe "DELETE #destroy" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        @other_user = create(:user)
        sign_in @user
        @favorite = create(:favorite, follow: @other_user, user: @user)
      end
      it "deletes a favorite from a user" do
        expect {
          delete :destroy, xhr: true, params: { id: @favorite.id, follow_id: @favorite.follow.id }
        }.to change(@other_user.followers, :count).by(-1)
      end
    end
  end
end
