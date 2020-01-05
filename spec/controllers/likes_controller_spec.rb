require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe"POST #create" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        @other_user = create(:user)
        sign_in @user
        @post = create(:post, user: @other_user)
      end
      it "adds a like to a post" do
        expect {
          post :create, xhr: true, params: { post_id: @post.id }
        }.to change(@post.likes, :count).by(1)
      end
    end
  end
  describe "DELETE #destroy" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        @other_user = create(:user)
        sign_in @user
        @post = create(:post, user: @other_user)
        @like = create(:like, post: @post, user: @user)
      end
      it "deletes a like from a post" do
        expect {
          delete :destroy, xhr: true, params: { id: @like.id, post_id: @like.post.id }
        }.to change(@post.likes, :count).by(-1)
      end
    end
  end
end