require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index_traveler" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        sign_in @user
        get :index_traveler
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        get :index_traveler
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :index_traveler
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #search_traveler" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        sign_in @user
        get :search_traveler
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        get :search_traveler
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :search_traveler
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #index_local" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        sign_in @user
        get :index_local
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        get :index_local
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :index_local
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #search_local" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        sign_in @user
        get :search_local
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        get :search_local
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :search_local
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #show" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #favorite" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        sign_in @user
        get :favorite, params: { id: @user.id }
        expect(response).to be_successful
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        get :favorite, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :favorite, params: { id: @user.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #edit" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        sign_in @user
        get :edit, params: { id: @user.id }
        expect(response).to be_successful
      end
    end
    context "as an unauthorized user" do
      before do
        @user = create(:user)
        @other_user = create(:user)
        sign_in @other_user
      end
      it "redirects to the dashboard" do
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to posts_top_path
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        get :edit, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "GET #unsubscribe" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "responds successfully" do
        sign_in @user
        get :unsubscribe, params: { id: @user.id }
        expect(response).to be_successful
      end
    end
    context "as an unauthorized user" do
      before do
        @user = create(:user)
        @other_user = create(:user)
        sign_in @other_user
      end
      it "redirects to the dashboard" do
        get :unsubscribe, params: { id: @user.id }
        expect(response).to redirect_to posts_top_path
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        get :unsubscribe, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :unsubscribe, params: { id: @user.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe"PATCH #update"do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "updates a user" do
        user_params = attributes_for(:user, name_user: "MSK")
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name_user).to eq "MSK"
      end
    end

#     context "as an unauthorized user" do
# pending "didn't set yet"
#     end

    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        user_params = attributes_for(:user)
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        user_params = attributes_for(:user)
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe"PATCH #status_user"do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "updates a user status" do
        user_params = attributes_for(:user, status_user: 1)
        patch :status_user, params: { id: @user.id, user: user_params }
        expect(@user.reload.status_user).to eq 1
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        user_params = attributes_for(:user)
        patch :status_user, params: { id: @user.id, user: user_params }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        user_params = attributes_for(:user)
        patch :status_user, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "DELETE #destroy" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "deletes a user" do
        expect {
          delete :destroy, params: { id: @user.id }
        }.to change(User, :count).by(-1)
      end
    end
    context "as a guest" do
      before do
        @user = create(:user)
      end
      it "returns a 302 response" do
        delete :destroy, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        delete :destroy, params: { id: @user.id }
        expect(response).to redirect_to "/users/sign_in"
      end
      it "does not delete the user" do
        expect {
          delete :destroy, params: { id: @user.id }
        }.to_not change(User, :count)
      end
    end
  end
end