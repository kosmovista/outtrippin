class ItinerariesController < ApplicationController
  before_action :set_homepage_type, only: [:create]
  before_action :set_itinerary, except: [:index, :create, :browse]
  before_action :load_styles_personalities, only: [:details, :finalize, :update, :publish]
  before_action :authorize_user, only: [:index] # TODO some more actions should be here
  before_action :store_location

  def index
    @itineraries = current_user.itineraries unless current_user.is?("expert")
    @itineraries = Itinerary.published if current_user.is?("expert")
    @starred_itineraries = current_user.find_voted_items
    @pitched_itineraries = Pitch.find_by_user(current_user)
    @won_itineraries = Pitch.find_winner_expert_by_itinerary(current_user)
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

  def toggle_star
    if current_user.liked? @itinerary
      @itinerary.unliked_by current_user
    else
      current_user.likes @itinerary
    end
    redirect_to :back
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
        flash[:notice] = "Looks like there's already an account with that email address. Please login to continue! :)"
        session[:original_uri] = checkout_itinerary_path(@itinerary)
        redirect_to login_path
      else
        redirect_to checkout_itinerary_path(@itinerary)
      end
    else
      render 'finalize'
    end
  end

  def show
    @plan = @itinerary.plans.first if @itinerary.has_plan?
    if current_user
      @pitches = @itinerary.pitches
      @pitch = @pitches.where(user: current_user).first if current_user.is?("expert")
    end
    # TODO SET SOME PERMISSION HERE
    # authorize_user is not enough
  end

  def checkout
    @featuring_stories = FeaturedPlan.all.map { |p| p.plan }

    if !current_user
      flash[:notice] = "You have to login before getting to the checkout page."
      session[:original_uri] = checkout_itinerary_path(@itinerary)
      redirect_to login_path
    end
  end

  def browse
    @featuring_stories = FeaturedPlan.all.map { |p| p.plan }
    @itinerary = Itinerary.new
  end

  def purchase
    token = params[:stripeToken]
    plan = params[:plan].to_i

    if @itinerary.process_payment(token, plan)
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

  def email_sharer
    @destination = params[:emails].split(',')
    UserMailer.delay.email_sharer_email(@destination, params[:message], @itinerary)
    flash[:notice] = "Emails are on their way!"
    redirect_to :back
  end

  private

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:destination)
  end

  # TODO REFACTOR THIS
  def load_styles_personalities
    @styles = YAML.load_file(File.join(Rails.root.to_s, 'config', 'styles.yml'))
    @personalities = YAML.load_file(File.join(Rails.root.to_s, 'config', 'personalities.yml'))
  end
end