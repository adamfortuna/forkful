class LocationPost < ApplicationRecord
  belongs_to :location
  belongs_to :post
  belongs_to :admin_user, foreign_key: :user_id

  validates :location, presence: true
  validates :post, presence: true

  scope :by_order, -> { order('location_posts.order') }

  accepts_nested_attributes_for :location, :reject_if => :all_blank

  def as_json(options={})
    {
      order: order,
      show_order: show_order,
      name: location.name,
      slug: location.slug,
      short_description: location.short_description,
      description: location.description,
      rating: location.rating,
      website: location.website,
      photo: location.photo.url(:thumb),
      photo_src: location.photo_src,
      photo_src_url: location.photo_src_url,
      address: location.address
    }
  end
end
