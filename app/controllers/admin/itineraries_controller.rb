class Admin::ItinerariesController < ApplicationController
  before_action :authorize_user
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
    @itinerary.destination = params[:itinerary][:destination]
    @itinerary.departure = params[:itinerary][:departure]
    @itinerary.duration = params[:itinerary][:duration]
    @itinerary.extra_info[:name] = params[:itinerary][:name]
    @itinerary.extra_info[:travelers] = params[:itinerary][:travelers]
    @itinerary.extra_info[:must] = params[:itinerary][:must]
    @itinerary.extra_info[:avoid] = params[:itinerary][:avoid]
    @itinerary.extra_info[:details] = params[:itinerary][:details]
    @itinerary.extra_info[:reward] = params[:itinerary][:reward]
    @itinerary.extra_info[:countdown] = params[:itinerary][:countdown]
    @itinerary.save!
    redirect_to @itinerary
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.delete
    redirect_to :back
  end
end