class AreaLocation < ApplicationRecord
  belongs_to :location
  belongs_to :area, counter_cache: :locations_count

  validates :location, presence: true
  validates :area, presence: true

  accepts_nested_attributes_for :area, :reject_if => :all_blank

  def as_json(options={})
    {
      name: location.name,
      slug: location.slug,
      short_description: location.short_description,
      description: location.description,
      rating: location.rating,
      website: location.website,
      website: location.review_url,
      photo: location.photo.url(:thumb),
      photo_src: location.photo_src,
      photo_src_url: location.photo_src_url,
      address: location.address
    }
  end
end
