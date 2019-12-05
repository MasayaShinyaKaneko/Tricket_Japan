class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
		posts_top_path
	end
	def after_sign_up_path_for(resource)
		user_path(current_user)
	end

	before_action :configure_permitted_parameters, if: :devise_controller?
	protected
	def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:type_user, :name_first, :name_last, :name_user, :gender, :birthday, :nationality, :country, :language_first, :language_second, :language_third, :hobby, :introduction, :picture_profile, :picture_background])
    end
end
