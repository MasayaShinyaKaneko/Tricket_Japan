class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	has_many :posts, dependent: :destroy
	has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy

  mount_uploader :picture_profile, ImageUploader
  mount_uploader :picture_background, ImageUploader

end
