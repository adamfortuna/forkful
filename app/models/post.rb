class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :photo, PhotoUploader

  belongs_to :admin_user, foreign_key: :user_id

  has_many :location_posts, inverse_of: :post
  has_many :locations, through: :location_posts

  accepts_nested_attributes_for :location_posts, allow_destroy: true
  accepts_nested_attributes_for :locations

  scope :by_date, -> { order('created_at desc') }
  scope :published, -> { where(['published_at < ?', Time.now]) }

  # Types
  scope :maps, -> { where(type: 'Map') }
  scope :reviews, -> { where(type: 'Review') }
  scope :broadcasts, -> { where(type: 'Broadcast') }
  scope :events, -> { where(type: 'Event') }

  def should_generate_new_friendly_id?
    title_changed?
  end

  def image # todo: discontinue
    photo.url(:thumb)
  end

  def photo_thumb
    photo.url(:thumb)
  end

  def photo_poster
    photo.url(:poster)
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
