require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
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
end
