class HomeController < ApplicationController
  def contact; end
  def about; end

  def index
    @featured_posts = Seed.data.featured_posts.active

    @broadcasts = Broadcast.published.by_date.limit(6)
    @broadcasts_count = Broadcast.count

    @featured_articles = Seed.data.featured_article
    @bests = Seed.data.best.all
    @reviews = Seed.data.reviews.active
    @maps = Map.published.by_date.limit(8)
  end
end
