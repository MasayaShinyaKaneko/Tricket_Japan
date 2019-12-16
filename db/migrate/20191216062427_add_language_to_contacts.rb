class AddLanguageToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :reply_language, :integer
  end
end
