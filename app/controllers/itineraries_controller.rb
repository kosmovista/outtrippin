class ItinerariesController < ApplicationController

  def create
    @itinerary = Itinerary.new(itinerary_params)
    if @itinerary.save
      redirect_to details_itinerary_path(@itinerary)
    else
      render 'home#index'
    end
  end

  def update

  end

  def details

  end

  def finalize

  end

  def publish

  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:destination)
  end
end