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
    		if @contact.reply_language == 1
    			ContactMailer.send_when_admin_reply_japanese(@user, @contact).deliver
        	flash[:success] = "日本語で送信が完了いたしました。"
        else @contact.reply_language == 2
				  ContactMailer.send_when_admin_reply_english(@user, @contact).deliver
		      flash[:success] = "英語で送信が完了いたしました。"
		    end
        @contact.update(status_reply: 1)
    		render :show
      else
        flash[:error] = "エラー。送信でできませんでした。"
    		render :show
      end
	end

	private
    def contact_params
    	params.require(:contact).permit(:user_id, :subject, :content, :reply, :status_reply, :reply_language)
    end
end
