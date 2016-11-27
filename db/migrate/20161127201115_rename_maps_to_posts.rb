class RenameMapsToPosts < ActiveRecord::Migration[5.0]
  def change
    rename_table :maps, :posts
    add_column :posts, :type, :string

    rename_table :location_maps, :location_posts
    rename_column :location_posts, :map_id, :post_id
    add_index :location_posts, :post_id
    add_index :location_posts, :location_id
  end
end
