class ReviewsController < ApplicationController
  respond_to :html, :json

  def index
    @reviews = Review.published.page(params[:page])
    @review = @reviews.first
  end

  def show
    @review = Review.friendly.find params[:id]
  end
end
