class Forkful::SocialSites::Yelp < Forkful::SocialSites::Site
  def lookup
    details = Yelp.client.business(remote_id)
    Forkful::Business.new({
      site: 'Yelp',
      rating: details.business.rating
    })
  end
end
