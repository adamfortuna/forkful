class Forkful::SocialSites::Yelp < Forkful::SocialSites::Site
  def lookup
    details = Yelp.client.business(remote_id)

    Forkful::Business.new({
      site: 'Yelp',
      rating: details.business.rating,
      name: details.business.name,
      address: Address.new(
        street: details.business.location.address.join(", "),
        city: details.business.location.city,
        region: details.business.location.state_code,
        postal_code: details.business.location.postal_code,
        country: details.business.location.country_code,
        lat: details.business.location.coordinate.latitude,
        lng: details.business.location.coordinate.longitude
      )
    })
  end
end
