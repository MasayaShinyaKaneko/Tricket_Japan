class Post < ApplicationRecord
	belongs_to :user
	has_many :likes, dependent: :destroy

 	mount_uploader :post_image, ImageUploader
	mount_uploader :image_accomplishment, ImageUploader

    def liked_by?(user)
      likes.where(user_id: user.id).exists?
    end
end