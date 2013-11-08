class Admin::ItinerariesController < ApplicationController
  before_action :authorize_admin

  def index
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.delete
    redirect_to :back
  end
end