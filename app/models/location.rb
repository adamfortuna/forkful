class Location < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :photo, PhotoUploader

  belongs_to :address
  has_many :area_locations, inverse_of: :location
  has_many :areas, through: :area_locations, inverse_of: :locations

  has_many :location_social_sites, inverse_of: :location
  has_many :social_sites, through: :location_social_sites

  has_many :location_posts, inverse_of: :location
  has_many :posts, through: :location_posts

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :areas
  accepts_nested_attributes_for :area_locations

  accepts_nested_attributes_for :location_social_sites, allow_destroy: true
  accepts_nested_attributes_for :social_sites

  def should_generate_new_friendly_id?
    name_changed?
  end

  def review
    posts.reviews.first
  end

  def has_review?
    !review.nil?
  end

  def self.new_from_business business
    Location.new.tap do |location|
      location.name = business.name
      location.address = business.address
    end
  end

  def self.find_or_initialize_from_yelp yelp_id
    yelp = SocialSite.where(slug: 'yelp').first or raise "No Yelp"
    if social_site = LocationSocialSite.where(remote_id: yelp_id, social_site_id: yelp.id).first
      return social_site.location
    end

    business = Forkful::SocialSites::Yelp.new(yelp_id).lookup
    location = Location.new_from_business(business)

    location.location_social_sites << LocationSocialSite.new({
      url: "https://www.yelp.com/biz/#{yelp_id}",
      remote_id: yelp_id,
      social_site_id: yelp.id
    })

    location
  end

  def directions_url
    "https://www.google.com/maps/place/#{address.address}"
  end
end
