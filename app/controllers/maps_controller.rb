class MapsController < ApplicationController
  respond_to :html, :json

  def index
    @maps = Map.all
  end

  def show
    @map = Map.friendly.includes(
      location_posts: [
        location: [
          :address,
          :areas,
          :posts,
          location_social_sites: [
            :social_site
          ]
        ]
      ])
      .find(params[:id])

    respond_with @map
  end
end
