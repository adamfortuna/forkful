class Area < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :area_locations, inverse_of: :area
  has_many :locations, through: :area_locations, inverse_of: :areas

  def should_generate_new_friendly_id?
    name_changed?
  end

  def as_json(options={})
    {
      title: name,
      slug: slug,
      locations: area_locations
    }
  end
end
