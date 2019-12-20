# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # GET /resource/sign_up
  def new
      @nationality = NATIOALITY
      @country = COUNTRY
      @language = LANGUAGE
      if params[:type_user] == "0"
        @view = 0
      elsif params[:type_user] == "1"
        @view = 1
      end
      super
  end

  # POST /resource
  def create
      @nationality = NATIOALITY
      @country = COUNTRY
      @language = LANGUAGE
      #下記if文はparanoia用
      if User.only_deleted.pluck(:name_user).include?(user_params[:name_user])
        flash[:name_notice] = "This user name is already taken."
        redirect_to new_user_registration_path
      elsif User.only_deleted.pluck(:email).include?(user_params[:email])
        flash[:email_notice] = "This email address is not available."
        redirect_to new_user_registration_path
      else
      #ここまで
        flash[:success] = "You have created account successfully."
        super
      end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  private #paranoia用
    def user_params
        params.require(:user).permit(:type_user, :name_first, :name_last, :name_user, :gender, :birthday, :nationality, :country, :language_first, :language_second, :language_third, :hobby, :introduction, :picture_profile, :picture_background, :email)
    end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
