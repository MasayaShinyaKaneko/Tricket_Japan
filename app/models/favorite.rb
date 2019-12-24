class Favorite < ApplicationRecord

  validates :user_id, presence: true, uniqueness: { scope: :follow_id }
  validates :follow_id, presence: true

  belongs_to :user
  belongs_to :follow, class_name: 'User'

  def self.most_favorited_userId_month
      self.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day).group(:follow_id).order('count(follow_id) desc').pluck(:follow_id)
  end
  def self.most_favorited_userId
      self.group(:follow_id).order('count(follow_id) desc').pluck(:follow_id)
  end
  def self.least_favorited_userId
      self.group(:follow_id).order('count(follow_id) asc').pluck(:follow_id)
  end
end
