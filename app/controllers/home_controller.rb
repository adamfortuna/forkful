class HomeController < ApplicationController
  def contact; end
  def about; end

  def index
    @featured_posts = Post.published.with_any_highlights(:spotlight).by_date.limit(3)

    # News - Top 8
    @broadcasts = Broadcast.published.by_date.limit(6)
    @broadcasts_count = Broadcast.published.count

    # Guide - Recently Featured
    @guide = Guide.published.with_any_highlights(:feature).by_date.limit(1).first
    @guides_count = Guide.published.count

    # Reviews - Recent 3
    @reviews = Review.published.by_date.limit(3)
    @reviews_count = Review.published.count

    # Best Of Lists - Recent 3
    @bests = Seed.data.best.all

    # Maps - Recent 8
    @maps = Map.published.by_date.limit(8)
  end
end
