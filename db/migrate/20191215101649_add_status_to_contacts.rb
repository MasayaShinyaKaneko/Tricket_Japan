class AddStatusToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :status_reply, :integer, default: 0, null: false
  end
end
