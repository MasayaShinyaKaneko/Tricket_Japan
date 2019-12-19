class Room < ApplicationRecord

	has_many :messages, dependent: :destroy
	has_many :room_users, dependent: :destroy

  def self.new_message(current_user)
      self.order("updated_at desc").joins(:room_users).where("room_users.user_id = ?", current_user.id).distinct
  end
end
