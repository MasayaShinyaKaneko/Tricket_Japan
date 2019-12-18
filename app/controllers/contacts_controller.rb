class ContactsController < ApplicationController

	before_action :authenticate_user!

	def new
		@contact = Contact.new
	end
	def create
		@contact = Contact.new(contact_params)
    	@contact.user_id = current_user.id
    	if  @contact.save
    		ContactMailer.send_when_user_message(current_user, @contact).deliver
			@contact = Contact.new
        	flash[:success] = "You have sent the message successfully."
    		render :new
        else
        	flash[:error] = "error!!"
        	render :new
        end
	end
	private
	    def contact_params
	    	params.require(:contact).permit(:user_id, :subject, :content, :reply)
	    end
end
