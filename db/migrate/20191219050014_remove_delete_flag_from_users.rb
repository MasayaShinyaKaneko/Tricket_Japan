class RemoveDeleteFlagFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :delete_flag, :integer
  end
end
