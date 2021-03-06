require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
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
  describe "GET #show" do
    context "as an authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @room = create(:room)
        @room_user = create(:room_user, user: @user, room: @room)
      end
      it "responds successfully" do
        get :show, params: { id: @room.id }
        expect(response).to be_successful
      end
    end
    context "as an unauthorized user" do
      before do
        @user = create(:user)
        @other_user = create(:user)
        sign_in @user
        @room = create(:room)
        @room_user = create(:room_user, user: @other_user, room: @room)
      end
      it "redirects to the dashboard" do
        get :show, params: { id: @room.id }
        expect(response).to redirect_to posts_top_path
      end
    end
    context "as a guest" do
      before do
        @room = create(:room)
      end
      it "returns a 302 response" do
        get :show, params: { id: @room.id }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :show, params: { id: @room.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "POST #create" do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        @other_user = create(:user)
        sign_in @user
      end
      it "adds a room" do
        room_user_params = attributes_for(:room_user, user_id: @other_user.id)
        expect {
          post :create, params: { room_user: room_user_params }
        }.to change(@user.rooms, :count).by(1)
      end
    end
    context "as a guest" do
      it "returns a 302 response" do
        room_params = attributes_for(:room)
        post :create, params: { room: room_params }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        room_params = attributes_for(:room)
        post :create, params: { room: room_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "PATCH #status_open"do
    context "as an authenticated user" do
      before do
        @user = create(:user)
        sign_in @user
        @room = create(:room, :with_messages)
      end
      it "updates messages status" do
        patch :status_open, params: { room_id: @room.id }
        expect(@room.messages).to all(satisfy {|message| message.reload.status_open == 1 })
      end
    end
    context "as a guest" do
      it "returns a 302 response" do
        room_params = attributes_for(:room)
        post :create, params: { room: room_params }
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        room_params = attributes_for(:room)
        post :create, params: { room: room_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
