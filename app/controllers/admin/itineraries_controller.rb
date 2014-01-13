class Admin::ItinerariesController < ApplicationController
  before_action :authorize_admin

  def index
  end

  def edit
    @itinerary = Itinerary.find(params[:id])
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    @itinerary.extra_info[:details] = params[:itinerary][:details]
    @itinerary.save!
    redirect_to @itinerary
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.delete
    redirect_to :back
  end
end