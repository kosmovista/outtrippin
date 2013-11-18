class PitchesController < ApplicationController
  layout 'itineraries'

  # should guarantee an EXPERT!
  before_action :set_itinerary

  def new
    @pitch_new = PitchNew.new(itinerary: @itinerary, user: current_user)
  end

  def create
    @pitch_new = PitchNew.new(itinerary: @itinerary, user: current_user, attributes: params[:pitch_new])
    if @pitch_new.save
      redirect_to itinerary_path(@itinerary)
    else
      render 'new'
    end
  end

  def edit
    @pitch_new = PitchNew.new(itinerary: @itinerary, user: current_user)
  end

  def set_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

end