class Admins::ContactsController < ApplicationController
	def index
		@contacts = Contact.all
	end
	def show
		@contact = Contact.find(params[:id])
		@user = @contact.user
	end
	def update
      	@contact = Contact.find(params[:id])
		@user = @contact.user
    	ContactMailer.send_when_admin_reply(@user, @contact).deliver
    	if  @contact.update(contact_params)
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
