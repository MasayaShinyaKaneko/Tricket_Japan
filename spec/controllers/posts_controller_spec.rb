require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #top" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        get :top
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      it "returns a 302 response" do
        get :top
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :top
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #index" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        get :index
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #sort" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        get :sort
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      it "returns a 302 response" do
        get :sort
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :sort
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #show" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        sign_in @user
        @post = create(:post)
      end
      it "responds successfully" do
        get :show, params: { id: @post.id }
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      before do
        @post = create(:post)
      end
      it "responds successfully" do
        get :show, params: { id: @post.id }
        expect(response).to be_successful
      end
    end
  end
  describe "GET #new" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        get :new
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      it "returns a 302 response" do
        get :new
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :new
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #index_photo" do
    context "as a logged in user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        get :index_photo
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      it "returns a 302 response" do
        get :index_photo
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :index_photo
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #edit" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @post = create(:post, user: @user)
      end
      it "responds successfully" do
        get :edit, params: { id: @post.id }
        expect(response).to be_successful
      end
    end
    context "as an unauthorized user" do
      before do
        @user = create(:user)
        @other_user = create(:user)
        sign_in @user
        @post = create(:post, user: @other_user)
      end
      it "redirects to the dashboard" do
        get :edit, params: { id: @post.id }
        expect(response).to redirect_to posts_top_path
      end
    end
    context "as a guest" do
      before do
        @post = create(:post)
      end
      it "returns a 302 response" do
        get :edit, params: { id: @post.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :edit, params: { id: @post.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe"POST #create" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      context "with valid attributes" do
        it "adds a post" do
          post_params = attributes_for(:post)
          expect {
            post :create, params: { post: post_params }
          }.to change(@user.posts, :count).by(1)
        end
      end
      context "with invalid attributes" do
        it "does not add a post" do
          post_params = attributes_for(:post, :invalid)
          expect {
            post :create, params: { post: post_params }
          }.to_not change(@user.posts, :count)
        end
      end
    end
    context "as a guest" do
      it "returns a 302 response" do
        post_params = attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        post_params = attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "PATCH #update_accomplish" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @post = create(:post, user: @user)
      end
      it "updates a post status for accomplishment" do
        post_params = attributes_for(:post, status_accomplishment: 1)
        patch :update_accomplish, params: { id: @post.id, post: post_params }
        expect(@post.reload.status_accomplishment).to eq "Accomplished"
      end
    end
    context "as a guest" do
      before do
        @post = create(:post)
      end
      it "returns a 302 response" do
        post_params = attributes_for(:post, status_accomplishment: 1)
        patch :update_accomplish, params: { id: @post.id, post: post_params }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        post_params = attributes_for(:post, status_accomplishment: 1)
        patch :update_accomplish, params: { id: @post.id, post: post_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "PATCH #reset_accomplish" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @post = create(:post, user: @user, status_accomplishment: 1)
      end
      it "updates a post status for accomplishment" do
        post_params = attributes_for(:post, status_accomplishment: 0)
        patch :reset_accomplish, params: { id: @post.id, post: post_params }
        expect(@post.reload.status_accomplishment).to eq "Ongoing"
      end
    end
    context "as a guest" do
      before do
        @post = create(:post)
      end
      it "returns a 302 response" do
        post_params = attributes_for(:post, status_accomplishment: 0)
        patch :reset_accomplish, params: { id: @post.id, post: post_params }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        post_params = attributes_for(:post, status_accomplishment: 0)
        patch :reset_accomplish, params: { id: @post.id, post: post_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "PATCH #update" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @post = create(:post, user: @user)
      end
      it "updates a post" do
        post_params = attributes_for(:post, title: "Test Post")
        patch :update, params: { id: @post.id, post: post_params }
        expect(@post.reload.title).to eq "Test Post"
      end
    end
    context "as a guest" do
      before do
        @post = create(:post)
      end
      it "returns a 302 response" do
        post_params = attributes_for(:post, title: "Test Post")
        patch :update, params: { id: @post.id, post: post_params }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        post_params = attributes_for(:post, title: "Test Post")
        patch :update, params: { id: @post.id, post: post_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "DELETE #destroy" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @post = create(:post, user: @user)
      end
      it "deletes a post" do
        expect {
          delete :destroy, params: { id: @post.id }
        }.to change(Post, :count).by(-1)
      end
    end
    context "as a guest" do
      before do
        @post = create(:post)
      end
      it "returns a 302 response" do
        delete :destroy, params: { id: @post.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        delete :destroy, params: { id: @post.id }
        expect(response).to redirect_to "/users/sign_in"
      end
      it "does not delete the user" do
        expect {
          delete :destroy, params: { id: @post.id }
        }.to_not change(Post, :count)
      end
    end
  end
end
