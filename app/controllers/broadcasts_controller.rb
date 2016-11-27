class BroadcastsController < ApplicationController
  respond_to :html, :json

  def index
    @broadcasts = Broadcast.published.page(params[:page])
  end

  def show
    @broadcast = Broadcast.friendly.find params[:id]
    @broadcasts = Broadcast.published.page(1).per(5)
  end
end
