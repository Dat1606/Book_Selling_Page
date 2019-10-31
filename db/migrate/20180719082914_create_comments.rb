class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :content

      t.timestamps
    end
     add_index :comments, [:user_id, :created_at]
  end
end
