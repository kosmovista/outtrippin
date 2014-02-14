class Api::V1::StoriesController < ApplicationController
  respond_to :json
  before_action :set_story, only: [:show, :update]
  before_action :authorize_admin

  ## GET index
  def index
    @itineraries = Itinerary.all
    ap @user
  end

  ## GET show
  def show
  end

  ## POST create
  def create
    destination = params[:destination]
    @itinerary = Itinerary.new(destination: destination)
    if @itinerary.save
      render :show, status: 201
    else
      render json: { message: "Could not save story", errors: @itinerary.errors.full_messages }, status: 404
    end
  end

  ## PATCH update
  def update
    @itinerary = Itinerary.find(params[:id])
    ap story_params
    if @itinerary.update_attributes(story_params)
      render :show
    else
      render json: { message: "Could not update story", errors: @itinerary.errors.full_messages }, status: 400
    end
  end

  private
  def set_story
    ap params
    @itinerary = Itinerary.find(params[:id])
  end

  def story_params
    params.permit(:duration, :destination, :departure, extra_info: [:budget, :details, :name, :travelers, style:[]])
  end

  def verify_authenticity_token
    @user = User.find_by_single_access_token(request.headers["auth-token"])
    render json: { message: "Unauthorized" }, status: 401 if @user.nil?

  end

  def authorize_admin
    render json: { message: "Forbidden" }, status: 403 unless @user.admin?

  end
end