class AddNotificationToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :status_open, :integer, default: 0, null: false
  end
end
