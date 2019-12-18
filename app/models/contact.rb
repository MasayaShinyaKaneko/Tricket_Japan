class Contact < ApplicationRecord

  	validates :subject, presence: true
   	validates :content, presence: true, length: {in: 30..500}

	belongs_to :user

	enum status_reply: { notyet: 0, replyed: 1 }
end
