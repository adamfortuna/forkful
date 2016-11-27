class HomeController < ApplicationController
  def contact; end
  def about; end

  def index
    @featured_posts = Seed.data.featured_posts.active
    @news = Seed.data.news.active
    @featured_articles = Seed.data.featured_article
    @bests = Seed.data.best.all
    @reviews = Seed.data.reviews.active
    @maps = Seed.data.maps.active
  end
end
