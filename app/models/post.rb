class Post < ApplicationRecord
	belongs_to :user
	has_many :likes, dependent: :destroy
	has_many :comments, dependent: :destroy

 	mount_uploader :post_image, ImageUploader
	mount_uploader :image_accomplishment, ImageUploader

	enum status_accomplishment: { ongoing: 0, Accomplished: 1 }

    def liked_by?(user)
      likes.where(user_id: user.id).exists?
    end
end
