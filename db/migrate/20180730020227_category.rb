class Category < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
    t.references :general_category
    t.string :name
    t.timestamps
    end
  end
end
