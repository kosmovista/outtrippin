class HomeController < ApplicationController
  before_action :set_homepage_type

  def index
    @itinerary = Itinerary.new
  end

  private

  def set_homepage_type
    @homepage_type = "default"
  end
end