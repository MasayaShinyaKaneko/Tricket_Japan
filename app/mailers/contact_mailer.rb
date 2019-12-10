class ContactMailer < ApplicationMailer
  def send_when_admin_reply(user, contact) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    @answer = contact.reply #返信内容
    mail to: user.email, subject: '【サイト名】 お問い合わせありがとうございます'
  end

  def send_when_user_message(user, contact) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    @subject = contact.subject #送信タイトル
    @message = contact.content #送信内容
    mail to: user.email, subject: '【サイト名】 お問い合わせ届いております。'
  end
end
