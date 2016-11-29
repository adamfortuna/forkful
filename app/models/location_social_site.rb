class LocationSocialSite < ApplicationRecord
  belongs_to :location
  belongs_to :social_site

  validates :location, presence: true
  validates :social_site, presence: true
  validates :url, presence: true

  default_scope -> { includes(:social_site).order('social_sites.name') }

  accepts_nested_attributes_for :social_site, :reject_if => :all_blank

  before_create :fetch_remote_rating
  before_update :fetch_remote_rating, if: :remote_id_changed?

  private

  def fetch_remote_rating
    if social_site.lookup?
      self.remote_id = self.remote_id.strip
      business = social_site.lookup(self.remote_id)
      self.rating = business.rating
      self.rating_updated_at = Time.now
    end
  end
end
