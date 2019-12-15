class Contact < ApplicationRecord
	belongs_to :user

	enum status_reply: { notyet: 0, replyed: 1 }
end
