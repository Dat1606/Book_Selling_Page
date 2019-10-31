class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :book_id
    add_index :likes, [:user_id, :book_id], unique: true
  end
end
