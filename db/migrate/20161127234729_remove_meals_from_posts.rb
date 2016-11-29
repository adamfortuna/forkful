class RemoveMealsFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :meals_value
  end
end
