class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :post_image
      t.integer :user_id, null: false
      t.string :area, null: false
      t.string :season, null: false
      t.string :interest, null: false
      t.string :time_todo, null: false
      t.string :place_todo, null: false
      t.integer :status_accomplishment, null: false, default: 0
      t.integer :status_display, null: false, default: 0
      t.integer :delete_flag, null: false, default: 0
      t.string :comment_accomplishment
      t.string :image_accomplishment

      t.timestamps
    end
  end
end
