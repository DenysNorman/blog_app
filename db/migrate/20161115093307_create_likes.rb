class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.boolean :like
      t.boolean :dislike
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
