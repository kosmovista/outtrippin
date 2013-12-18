class ItinerariesController < ApplicationController
  before_action :set_homepage_type, only: [:create]
  before_action :set_itinerary, except: [:index, :create]
  before_action :load_styles, only: [:details, :update]
  before_action :authorize_user, only: [:index, :show] # TODO some more actions should be here

  def index
    @itineraries = current_user.itineraries
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    if @itinerary.save
      redirect_to details_itinerary_path(@itinerary)
    else
      render 'home/index', layout: 'application'
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
    if @itinerary_finalize.save
      if !current_user
        flash[:notice] = "you have to login"
        redirect_to login_path(itinerary: @itinerary)
      else
        redirect_to itinerary_path(@itinerary)
      end
    else
      render 'finalize'
    end
  end

  def show
    @pitches = @itinerary.pitches
    @pitch = @pitches.where(user: current_user).first if current_user.is?("expert")
    # TODO SET SOME PERMISSION HERE
    # authorize_user is not enough
  end

  def checkout

  end

  def purchase
    token = params[:stripeToken]

    if @itinerary.process_payment(token)
      UserMailer.delay.payment_received_email(@itinerary.user, @itinerary)
      AdminMailer.delay.payment_received_email(@itinerary)
      flash[:fresh_purchase] = true
      redirect_to thankyou_itinerary_path(@itinerary)
    else
      render 'checkout'
    end
  end

  def thankyou
    if flash[:fresh_purchase]
    elsif false # TODO: if itinerary is not paid, take it to the checkout page
    else
      redirect_to root_url
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