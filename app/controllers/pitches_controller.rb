class PitchesController < ApplicationController
  layout 'itineraries'

  # should guarantee an EXPERT!
  before_action :authorize_expert, except: [:winner]
  before_action :set_itinerary
  before_action :set_pitch, only: [:edit, :update, :winner, :remove]

  def new
    unless @itinerary.pitches.map { |p| p.user }.include?(current_user)
      @pitch_new = PitchNew.new(itinerary: @itinerary, user: current_user)
    else
      redirect_to itinerary_path(@itinerary), notice: "You can only submit one pitch per itinerary. If you want, you can edit the pitch you have already submitted on the 'My Pitch' tab."
    end
  end

  def create
    unless @itinerary.pitches.map { |p| p.user }.include?(current_user)
      @pitch_new = PitchNew.new(itinerary: @itinerary, user: current_user, attributes: params[:pitch_new])
      if @pitch_new.save
        redirect_to itinerary_path(@itinerary)
      else
        render 'new'
      end
    else
      redirect_to itinerary_path(@itinerary), notice: "You can only submit one pitch per itinerary. If you want, you can edit the pitch you have already submitted on the 'My Pitch' tab."
    end
  end

  def edit
    @pitch_edit = PitchEdit.new(itinerary: @itinerary, user: current_user, pitch: @pitch)
  end

  def update
    @pitch_edit = PitchEdit.new(itinerary: @itinerary, user: current_user, pitch: @pitch, attributes: params[:pitch_edit])
    @pitch.auto = false
    if @pitch_edit.save
      redirect_to itinerary_path(@itinerary)
    else
      render 'edit'
    end
  end

  def winner
    if current_user == @itinerary.user || current_user.is?("admin")
      @pitch.winner = true
      @pitch.save
      UserMailer.delay.winner_expert_email(@pitch)
      AdminMailer.delay.winner_expert_email(@pitch)

      # deliver loser emails
      @itinerary.pitches.each do |p|
        UserMailer.delay.loser_expert_email(p) unless p.winner
      end

      @itinerary = Itinerary.find(params[:itinerary_id])
      @itinerary.published = !@itinerary.published
      @itinerary.save
    end
    redirect_to itinerary_path(@itinerary)
  end

  def remove
    @itinerary = Itinerary.find(params[:itinerary_id])
    @pitch.itinerary_id = nil
    @pitch.save

    redirect_to itinerary_path(@itinerary)
  end

  def set_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

  def set_pitch
    @pitch = Pitch.find(params[:id])
  end

end