class Post < ApplicationRecord

	validates :title, presence: true, length: {in: 1..100}
	validates :content, presence: true, length: {in: 1..500}
	validates :time_todo, presence: true, length: {in: 1..30}
	validates :place_todo, presence: true, length: {in: 1..30}

	belongs_to :user
	has_many :likes, dependent: :destroy
	has_many :comments, dependent: :destroy

	has_many :notifications, dependent: :destroy

 	mount_uploader :post_image, ImageUploader
	mount_uploader :image_accomplishment, ImageUploader

	enum status_accomplishment: { Ongoing: 0, Accomplished: 1 }
  enum status_display: { open: 0, closed: 1 }

  scope :open, -> { where(status_display: 0) }

    def liked_by?(user)
      likes.where(user_id: user.id).exists?
    end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべてuser_idを取得
    other_user_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    other_user_ids.each do |other_user_id|
      save_notification_comment!(current_user, comment_id, other_user_id['user_id'])
    end
    # 自分以外にコメントしている人がいない場合
    if other_user_ids.blank?
      save_notification_comment!(current_user, comment_id, user_id)
    end
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    if notification.valid?
      notification.save
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
