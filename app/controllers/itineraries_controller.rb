class ItinerariesController < ApplicationController
  before_action :set_itinerary, except: [:create]
  before_action :load_styles, only: [:details, :update]

  def create
    @itinerary = Itinerary.new(itinerary_params)
    if @itinerary.save
      redirect_to details_itinerary_path(@itinerary)
    else
      render 'home/index'
    end
  end

  def update
    @itinerary_details = ItineraryDetails.new({attributes: params[:itinerary_details], itinerary: @itinerary})
    if @itinerary_details.save
      redirect_to finalize_itinerary_path(@itinerary)
    else
      render 'details'
    end
  end

  def details
    @itinerary_details = ItineraryDetails.new(itinerary: @itinerary)
  end

  def finalize
    @itinerary_finalize = ItineraryFinalize.new(itinerary: @itinerary)
  end

  def publish
    @itinerary_finalize = ItineraryFinalize.new({attributes: params[:itinerary_finalize], itinerary: @itinerary})
    ap @itinerary_finalize.errors
    if @itinerary_finalize.save
      redirect_to root_url
    else
      render 'finalize'
    end
  end

  private

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:destination)
  end

  # TODO REFACTOR THIS
  def load_styles
    configuration_file = File.join(Rails.root.to_s, 'config', 'styles.yml')
    @styles = YAML.load_file(configuration_file)
  end
end