class Post < ApplicationRecord

  acts_as_paranoid

	validates :title, presence: true, length: {in: 1..50}, uniqueness: { scope: :user_id }
	validates :content, presence: true, length: {in: 1..500}
	validates :time_todo, presence: true, length: {in: 1..50}
	validates :place_todo, presence: true, length: {in: 1..50}
  validates :area, presence: true
  validates :season, presence: true
  validates :interest, presence: true
  validates :status_accomplishment, presence: true
  validates :status_display, presence: true

	belongs_to :user
	has_many :likes, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :notifications, dependent: :destroy

 	mount_uploader :post_image, ImageUploader
	mount_uploader :image_accomplishment, ImageUploader

	enum status_accomplishment: { Ongoing: 0, Accomplished: 1 }
  enum status_display: { open: 0, closed: 1 }

  scope :open, -> { where(status_display: 0) }

  def self.only_post_deleted_not_user
      self.with_deleted.where("name_user LIKE ?", "%%").joins(:user)
  end

  def liked_by?(user)
      likes.where(user_id: user.id).exists?
  end

  def create_notification_comment!(current_user, comment_id)
      if Comment.where(post_id: id).where(user_id: current_user.id).exists?
        other_user_ids = Comment.where(post_id: id).where.not(user_id: current_user.id).distinct.pluck(:user_id)
      else
        other_user_ids = Comment.where(post_id: id).distinct.pluck(:user_id)
      end
      other_user_ids.each do |other_user_id|
        save_notification_comment!(current_user, comment_id, other_user_id)
      end
      if other_user_ids.blank?
        save_notification_comment!(current_user, comment_id, user_id)
      end
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
      notification = current_user.active_notifications.new(
        post_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      if notification.valid?
        notification.save
      end
  end

  def create_notification_accomplish!(current_user)
      #Tricket達成通知
      other_user_ids = comments.where(post_id: id).where.not(user_id: current_user.id).distinct.pluck(:user_id)
      other_user_ids.each do |other_user_id|
        save_notification_accomplish!(current_user, other_user_id)
      end
  end

  def save_notification_accomplish!(current_user, visited_id)
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: visited_id,
        accomplish: true
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      if notification.valid?
        notification.save
      end
  end
end
