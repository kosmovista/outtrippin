class PitchesController < ApplicationController
  layout 'itineraries'

  # should guarantee an EXPERT!
  before_action :authorize_expert, except: [:winner]
  before_action :set_itinerary
  before_action :set_pitch, only: [:edit, :update, :winner]

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
    @pitch_edit = PitchEdit.new(itinerary: @itinerary, user: current_user, pitch: @pitch)
  end

  def update
    @pitch_edit = PitchEdit.new(itinerary: @itinerary, user: current_user, pitch: @pitch, attributes: params[:pitch_edit])
    if @pitch_edit.save
      redirect_to itinerary_path(@itinerary)
    else
      render 'edit'
    end
  end

  def winner
    if current_user == @itinerary.user
      @pitch.winner = true
      @pitch.save
      UserMailer.delay.winner_expert_email(@itinerary)
      AdminMailer.delay.winner_expert_email(@pitch)
    end
    redirect_to itinerary_path(@itinerary)
  end

  def set_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

  def set_pitch
    @pitch = Pitch.find(params[:id])
  end

end