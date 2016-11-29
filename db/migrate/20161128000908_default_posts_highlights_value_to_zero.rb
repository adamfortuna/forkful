class DefaultPostsHighlightsValueToZero < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :highlights_value, :integer, default: 0
  end
end
