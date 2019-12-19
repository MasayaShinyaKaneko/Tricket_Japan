class RemoveDeleteFlagFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :delete_flag, :integer
  end
end
