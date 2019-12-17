class Post < ApplicationRecord

	validates :title, presence: true
	validates :content, presence: true
	validates :time_todo, presence: true
	validates :place_todo, presence: true

	belongs_to :user
	has_many :likes, dependent: :destroy
	has_many :comments, dependent: :destroy

 	mount_uploader :post_image, ImageUploader
	mount_uploader :image_accomplishment, ImageUploader

	enum status_accomplishment: { ongoing: 0, Accomplished: 1 }

    scope :open, -> { where(status_display: 0) }

    def liked_by?(user)
      likes.where(user_id: user.id).exists?
    end
end
