class Admin::ItinerariesController < ApplicationController
  before_action :authorize_admin

  def index
  end

  def edit
    @itinerary = Itinerary.find(params[:id])
  end

  def toggle_published
    @itinerary = Itinerary.find(params[:itinerary_id])
    @itinerary.published = !@itinerary.published
    @itinerary.save
    redirect_to :back
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