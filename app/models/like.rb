class Like < ApplicationRecord

	validates :user_id, :uniqueness => {:scope => :post_id}

  belongs_to :user
  belongs_to :post


  def self.most_liked_postId
      self.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day).group(:post_id).order('count(post_id) desc').pluck(:post_id)
  end
end
