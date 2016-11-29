class SocialSite < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :location_social_sites, inverse_of: :social_site
  has_many :locations, through: :location_social_sites

  default_scope -> { order('name') }

  def should_generate_new_friendly_id?
    name_changed?
  end

  def lookup?
    Forkful::SocialSite.can_lookup?(self)
  end

  def lookup remote_id
    Forkful::SocialSite.setup(self).new(remote_id).lookup
  end
end
