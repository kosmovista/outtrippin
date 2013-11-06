class HomeController < ApplicationController
  before_action :set_homepage_type

  def index
    @itinerary = Itinerary.new
  end
end