class Admin::PlacesController < ApplicationController
  before_action :authorize_user
  before_action :authorize_admin

  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])
  end

  def remove_pitch
    @place = Place.find(params[:place_id])
    @pitch = Pitch.find(params[:pitch_id])
    @pitch.place_id = nil
    @pitch.save

    redirect_to admin_place_path(@place)
  end
end