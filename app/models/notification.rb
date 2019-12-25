class Notification < ApplicationRecord

	belongs_to :post, optional: true
	belongs_to :comment, optional: true
	belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
	belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  def self.unchecked_notification(current_user)
    self.where(checked: false).where(visited_id: current_user.id)
  end
end
