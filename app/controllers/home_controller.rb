class HomeController < ApplicationController
  before_action :set_homepage_type
  before_action :set_white_topbar

  def index
    @itinerary = Itinerary.new
    @featuring_stories = FeaturedPlan.all.map { |p| p.plan }
  end
  
  def hotels
  	@itinerary = Itinerary.new
  	render layout: 'hotel'
  end
end