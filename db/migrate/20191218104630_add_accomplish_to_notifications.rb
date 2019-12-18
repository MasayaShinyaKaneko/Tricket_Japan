class AddAccomplishToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :accomplish, :boolean, default: false, null: false
  end
end
