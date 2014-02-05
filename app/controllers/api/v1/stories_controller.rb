class Api::V1::StoriesController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token # TODO remove THIS before PRODUCTION
  before_action :set_story, only: [:show, :update]

  ## GET index
  def index
    @itineraries = Itinerary.all
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
    @itinerary = Itinerary.find(params[:id])
  end

  def story_params
    params.permit(:duration, :departure, extra_info: [:budget, :details, style:[]])
  end
end