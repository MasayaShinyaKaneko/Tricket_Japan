class Contact < ApplicationRecord

  validates :subject, presence: true, length: {in: 1..50}
  validates :content, presence: true, length: {in: 30..500}

	belongs_to :user

	enum status_reply: { notyet: 0, replyed: 1 }
end
