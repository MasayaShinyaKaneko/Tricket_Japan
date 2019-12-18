class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?


	def after_sign_in_path_for(resource)
		case resource
		when User
			posts_top_path
		when Admin
			admins_contacts_path
		end
	end

	def after_sign_out_path_for(resource_or_scope)
		case resource_or_scope
		when :user
		 	root_path
		when :admin
			new_admin_session_path
		end
	end

	NATIOALITY = ["Japanese","American","French","Italian"]

	COUNTRY = ["Japan","America","France","Italy"]

	LANGUAGE =  ["N/A","Japanese","English","French","Italian"]

	AREA =  ["N/A","Kanto(Tokyo area)","Kansai(Osaka area)","Hokkaido","Tohoku","Chubu","Chugoku","Shikoku","Kyushu","Okinawa"]

	SEASON = ["N/A","spring","summer","automn","winter"]

	INTEREST = ["N/A","food","shopping","entrainment","anime","music","history","religion","tradition","festival","nature","sport","outdoor"]

	protected
	def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:type_user, :name_first, :name_last, :name_user, :gender, :birthday, :nationality, :country, :language_first, :language_second, :language_third, :hobby, :introduction, :picture_profile, :picture_background])
    end
end
