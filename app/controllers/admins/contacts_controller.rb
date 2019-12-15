class Admins::ContactsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@contacts = Contact.all.reverse
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
        	flash[:notice] = "You have sent the message successfully."
    		render :show
        else
        	flash[:notice] = "error!!"
    		render :show
        end
	end
	private
	    def contact_params
	    	params.require(:contact).permit(:user_id, :subject, :content, :reply)
	    end
end
