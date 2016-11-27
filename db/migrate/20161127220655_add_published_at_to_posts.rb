class AddPublishedAtToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :published_at, :datetime
    add_index :posts, :published_at
  end
end
