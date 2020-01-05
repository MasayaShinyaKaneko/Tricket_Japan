require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "GET #edit" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        sign_in @user
        @comment = create(:comment, user: @user)
      end
      it "responds successfully" do
        get :edit, xhr: true, params: { id: @comment.id }
        expect(response).to be_successful
      end
    end
  end
  describe "POST #create" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @post = create(:post)
      end
      context "with valid attributes" do
        it "adds a comment" do
          comment_params = attributes_for(:comment)
          expect {
            post :create, params: { comment: comment_params, post_id: @post.id }
          }.to change(@user.comments, :count).by(1)
        end
      end
      context "with invalid attributes" do
        it "does not add a comment" do
          comment_params = attributes_for(:comment, :invalid)
          expect {
            post :create, params: { comment: comment_params, post_id: @post.id }
          }.to_not change(@user.comments, :count)
        end
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
        @post = create(:post)
      end
      it "returns a 302 response" do
        comment_params = attributes_for(:comment)
        post :create, params: { comment: comment_params, post_id: @post.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        comment_params = attributes_for(:comment)
        post :create, params: { comment: comment_params, post_id: @post.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "PATCH #update" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @post = create(:post)
        @comment = create(:comment, user: @user, post: @post)
      end
      it "updates a comment" do
        comment_params = attributes_for(:comment, content: "Test content1")
        patch :update, xhr: true, params: { id: @comment.id ,comment: comment_params }
        expect(@comment.reload.content).to eq "Test content1"
      end
    end
  end
  describe "DELETE #destroy" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @post = create(:post)
        @comment = create(:comment, user: @user, post: @post)
      end
      it "deletes a post" do
        expect {
          delete :destroy, params: { id: @comment.id }
        }.to change(@user.comments, :count).by(-1)
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
        @post = create(:post)
        @comment = create(:comment, user: @user, post: @post)
      end
      it "returns a 302 response" do
        delete :destroy, params: { id: @comment.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        delete :destroy, params: { id: @comment.id }
        expect(response).to redirect_to "/users/sign_in"
      end
      it "does not delete the user" do
        expect {
          delete :destroy, params: { id: @comment.id }
        }.to_not change(Comment, :count)
      end
    end
  end
end