class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :number, default: 1
      t.integer :user_id
      t.references :category, foreign_key: true
      t.references :publisher, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end
