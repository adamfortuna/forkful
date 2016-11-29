class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :photo, PhotoUploader

  include AttrBitwise
  attr_bitwise :highlights, mapping: [:spotlight, :feature]

  scope :with_any_highlights, lambda { |*highlights_sym|
    where(highlights_value: bitwise_union(*highlights_sym, 'highlights'))
  }
  scope :with_all_highlights, lambda { |*locales_sym|
    where(highlights_value: bitwise_intersection(*highlights_sym, 'highlights'))
  }

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

  # before_save :debug_me
  #
  # def debug_me
  #   binding.pry
  #   false
  # end

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

  def all_highlights
    Post::HIGHLIGHTS_MAPPING.reject do |h|
      !highlights.include?(h)
    end.collect { |h| h.last }
  end

  def all_highlights= h
    self.highlights = h.reject { |e| e.to_s.empty? }
  end

  def location
    locations.first
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
