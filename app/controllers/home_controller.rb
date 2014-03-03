class HomeController < ApplicationController
  before_action :set_homepage_type
  before_action :set_white_topbar
  before_action :set_cities

  def index
    @itinerary = Itinerary.new
    @featuring_stories = FeaturedPlan.all.map { |p| p.plan }
  end
end