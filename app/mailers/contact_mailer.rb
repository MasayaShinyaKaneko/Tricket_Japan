class ContactMailer < ApplicationMailer
  def send_when_admin_reply_japanese(user, contact) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    @answer = contact.reply #返信内容
    mail to: user.email, subject: '【Trikcet_Japan】お問い合わせのお返事'
  end
  def send_when_admin_reply_english(user, contact) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    @answer = contact.reply #返信内容
    mail to: user.email, subject: '【Trikcet_Japan】reply to your inquiry'
  end

  def send_when_user_message(user, contact) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    @subject = contact.subject #送信タイトル
    @message = contact.content #送信内容
    mail to: user.email, subject: '【Tricket_Japan】 お問い合わせありがとうございます。Thank you for your inquiry'
  end
end
