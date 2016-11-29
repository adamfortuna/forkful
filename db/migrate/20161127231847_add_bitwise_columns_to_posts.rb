class AddBitwiseColumnsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :meals_value, :integer
    add_column :posts, :highlights_value, :integer

    add_index :posts, :meals_value
    add_index :posts, :highlights_value
  end
end
