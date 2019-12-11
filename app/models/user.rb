class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	has_many :posts, dependent: :destroy
  has_many :contacts, dependent: :destroy
	has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy

  has_many :favorites
  has_many :followings, through: :favorites, source: :follow
  has_many :reverse_of_favorites, class_name: 'Favorite', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_favorites, source: :user

  def follow(other_user)
    if self != other_user
      self.favorites.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    favorite = self.favorites.find_by(follow_id: other_user.id)
    favorite.destroy if favorite
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  mount_uploader :picture_profile, ImageUploader
  mount_uploader :picture_background, ImageUploader

  enum type_user: { Traveler: 0, Local: 1 }
  enum status_user: { Active: 0, Busy: 1, Away: 2 }

end
