class Room < ApplicationRecord

	has_many :messages, dependent: :destroy
	has_many :room_users, dependent: :destroy

  def self.new_message(current_user)
      self.order("updated_at desc").joins(:room_users).where("room_users.user_id = ?", current_user.id).distinct
  end
  def self.unopened_message(current_user)
      self.joins(:room_users).where("room_users.user_id = ?", current_user.id).map(&:messages).flatten(1).select {|message| message.status_open == 0 && message.user_id != current_user.id }
  end
end
