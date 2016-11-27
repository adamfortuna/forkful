class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :photo, PhotoUploader

  belongs_to :admin_user, foreign_key: :user_id

  has_many :location_posts, inverse_of: :post
  has_many :locations, through: :location_posts

  accepts_nested_attributes_for :location_posts, allow_destroy: true
  accepts_nested_attributes_for :locations

  def should_generate_new_friendly_id?
    title_changed?
  end

  def image
    photo.url(:thumb)
  end

  def as_json(options={})
    {
      title: title,
      short_title: short_title,
      slug: slug,
      description: description,
      photo: photo.url(:thumb),
      photo_src: photo_src,
      photo_src_url: photo_src_url,
      locations: location_posts
    }
  end
end
