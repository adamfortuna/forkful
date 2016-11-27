class AreasController < ApplicationController
  respond_to :html, :json

  def index
    @areas = Area.order(:name).all
  end

  def show
    @area = Area.friendly.includes(
      area_locations: [
        location: [
          :address,
          :areas,
          :maps,
          location_social_sites: [
            :social_site
          ]
        ]
      ])
      .find(params[:id])

    respond_with @area
  end
end
