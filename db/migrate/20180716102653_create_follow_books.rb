class CreateFollowBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_books do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :follow_books, :user_id
    add_index :follow_books, :book_id
    add_index :follow_books, [:user_id, :book_id], unique: true
  end
end
