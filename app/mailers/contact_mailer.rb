class ContactMailer < ApplicationMailer
  def send_when_admin_reply_japanese(user, contact)
      @user = user
      @answer = contact.reply
      mail to: user.email, subject: '【Trikcet_Japan】お問い合わせのお返事'
  end
  def send_when_admin_reply_english(user, contact)
      @user = user
      @answer = contact.reply
      mail to: user.email, subject: '【Trikcet_Japan】reply to your inquiry'
  end

  def send_when_user_message(user, contact)
      @user = user
      @subject = contact.subject
      @message = contact.content
      mail to: user.email, subject: '【Tricket_Japan】 お問い合わせありがとうございます。Thank you for your inquiry'
  end
end
