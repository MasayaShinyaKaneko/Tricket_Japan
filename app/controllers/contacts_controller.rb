class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end
	def create
		@contact = Contact.new(contact_params)
    	@contact.user_id = current_user.id
    	if  @contact.save
        	flash[:notice] = "You have sent the message successfully."
			@contact = Contact.new
    		render :new
        else
        	flash[:notice] = "error!!"
			@contact = Contact.new
        	render :new
        end
	end
	private
	    def contact_params
	    	params.require(:contact).permit(:user_id, :subject, :content, :reply)
	    end
end