class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	has_many :favorites, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :likes, dependent: :destroy
	def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
	belongs_to :nationality
	belongs_to :country
end
