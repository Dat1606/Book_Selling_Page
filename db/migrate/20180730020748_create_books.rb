class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
    t.string :name
    t.integer :number, default: 1
    t.integer :user_id
    t.text :description
    t.references :category
    t.references :author
    t.references :publisher
    t.timestamps
    end
  end
end
