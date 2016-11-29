class AddRatingToLocationSocialSites < ActiveRecord::Migration[5.0]
  def change
    add_column :location_social_sites, :remote_id, :string
    add_column :location_social_sites, :rating, :float
    add_column :location_social_sites, :rating_updated_at, :datetime
  end
end
