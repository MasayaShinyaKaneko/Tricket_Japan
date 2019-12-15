class Admins::ContactsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@contacts = Contact.all.reverse
	end
	def search
		if params[:search_flag] == "1"
			@contacts = Contact.where("created_at LIKE ?", "%#{params[:date_search]}%")
		elsif params[:search_flag] == "2"
			@contacts = Contact.joins(:user).where("name_user LIKE ?", "%#{params[:user_search]}%")
		elsif params[:search_flag] == "3"
			@contacts = Contact.joins(:user).where("email LIKE ?", "%#{params[:email_search]}%")
		elsif params[:search_flag] == "4" && params[:sort_flag] == "0"
			@contacts = Contact.where(status_reply: 0).order('created_at DESC')
		elsif params[:search_flag] == "4" && params[:sort_flag] == "1"
			@contacts = Contact.where(status_reply: 1)
		end
		render :index
	end
	def show
		@contact = Contact.find(params[:id])
		@user = @contact.user
	end
	def update
      	@contact = Contact.find(params[:id])
		@user = @contact.user
    	if  @contact.update(contact_params)
    		ContactMailer.send_when_admin_reply(@user, @contact).deliver
        	flash[:notice] = "送信が完了いたしました。"
        	@contact.update(status_reply: 1)
    		render :show
        else
        	flash[:notice] = "エラー"
    		render :show
        end
	end
	private
	    def contact_params
	    	params.require(:contact).permit(:user_id, :subject, :content, :reply, :status_reply)
	    end
end
