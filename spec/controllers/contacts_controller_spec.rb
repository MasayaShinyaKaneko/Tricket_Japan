require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
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
  describe "POST #create" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
      end
      context "with valid attributes" do
        it "adds a contact" do
          contact_params = attributes_for(:contact)
          expect {
            post :create, params: { contact: contact_params }
          }.to change(@user.contacts, :count).by(1)
        end
      end
      context "with invalid attributes" do
        it "does not add a contact" do
          contact_params = attributes_for(:contact, :invalid)
          expect {
            post :create, params: { contact: contact_params }
          }.to_not change(@user.contacts, :count)
        end
      end
    end
    context "as a guest" do
      it "returns a 302 response" do
        contact_params = attributes_for(:contact)
        post :create, params: { contact: contact_params }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        contact_params = attributes_for(:contact)
        post :create, params: { contact: contact_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end