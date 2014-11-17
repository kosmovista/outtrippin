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
    @pitched_itineraries = Pitch.find_personalized_by_itinerary(current_user)
    @won_itineraries = Pitch.find_winner_expert_by_itinerary(current_user)
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)

    if !itinerary_params[:source].nil?
      @itinerary.extra_info[:source] = itinerary_params[:source]
    end
    
    if @itinerary.save
      if @itinerary.extra_info[:source] == "hotel"
        redirect_to gp_itinerary_path(@itinerary)
      else
        redirect_to details_itinerary_path(@itinerary)
      end
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

  def user
    if @user
      return @user
    else
      @password = generate_password
      @send_user_email = true 
      @user ||= User.new(email: @email, password: @password, password_confirmation: @password)
    end
  end
  
  attr_accessor :email

  def save 
    itinerary = params[:itinerary]
    newuser = params[:user]
    @itinerary.duration = itinerary[:duration]
    @itinerary.departure = itinerary[:departure]
    @itinerary.extra_info[:travelers] = itinerary[:extra_info][:travelers]
    @itinerary.extra_info[:name] = itinerary[:extra_info][:name]
    @itinerary.extra_info[:type] = itinerary[:extra_info][:type]
    @itinerary.extra_info[:time_frame] = itinerary[:extra_info][:time_frame]
    @itinerary.extra_info[:guest_type] = itinerary[:extra_info][:guest_type]
    @itinerary.extra_info[:activity_budget] = itinerary[:extra_info][:activity_budget]
    @itinerary.extra_info[:food_budget] = itinerary[:extra_info][:food_budget]
    @itinerary.extra_info[:age_group] = itinerary[:extra_info][:age_group]
    @itinerary.extra_info[:styles] = itinerary[:extra_info][:styles]
    @itinerary.extra_info[:details] = itinerary[:extra_info][:details]
    @itinerary.extra_info[:subtype] = itinerary[:extra_info][:subtype]
    @itinerary.extra_info[:printType] = itinerary[:extra_info][:printType]
    @itinerary.extra_info[:subscription_id] = itinerary[:extra_info][:subscription_id]
    @email = newuser[:email]
    @user = User.find_by_email(@email)
    user.save!
    if @itinerary.user.nil? 
      @itinerary.user = @user
      @user.roles = ["hotel"]
      user.save
      AdminMailer.delay.new_itinerary_email(@itinerary)
      UserMailer.delay.welcome_user_email(@user, @password, @itinerary) if @send_user_email
    end
    @itinerary.save!

    respond_to do |format|
      format.json { render :json => @export_data.to_json(:include => :user) }
    end
  end

  def gp
     render layout: 'hotelapp'
  end 

  def email_form
    render layout: false
  end 
  
  def travelers
    render layout: false
  end 
  
  def duration
    render layout: false
  end

  def budget
    render layout: false
  end  

  def interests
    render layout: false
  end  

  def subscription
    render layout: false
  end  

  def subscription_add
    render layout: false
  end  

  def checkout_form
    render layout: false
  end  

  def checkout_add
    render layout: false
  end  


  def finalize
    @itinerary_finalize = ItineraryFinalize.new(itinerary: @itinerary)
  end

  def publish
    @itinerary_finalize = ItineraryFinalize.new({attributes: params[:itinerary_finalize], itinerary: @itinerary})
    place = Place.find_by_name(@itinerary.destination.downcase.strip)
    if @itinerary_finalize.save
          # will copy the pitches that exist for this place
          # into the current itinerary (and reset the winners)
      @itinerary.get_pitches_from_place(place)
      if !current_user
        flash[:notice] = "Looks like there's already an account with that email address. Please login to continue! :)"
        session[:original_uri] = checkout_itinerary_path(@itinerary)
        redirect_to login_path
      else
        # check if we already have piches to add!
        if place.nil?
          redirect_to checkout_itinerary_path(@itinerary)
        else
          redirect_to itinerary_path(@itinerary)
        end
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
    @featuring_stories = Plan.where(published: true)
    @itinerary = Itinerary.new
  end

  def purchase
    token = params[:stripeToken]
    plan = params[:plan]

    if @itinerary.process_payment(token, plan)
      UserMailer.delay.payment_received_email(@itinerary.user, @itinerary)
      AdminMailer.delay.payment_received_email(@itinerary)
      flash[:fresh_purchase] = true
      if @itinerary.extra_info[:source] == "hotel"
        redirect_to itineraries_path
      else
        redirect_to thankyou_itinerary_path(@itinerary)
      end
    else
      if @itinerary.extra_info[:source] == "hotel"
        render 'gp'
      else
        render 'checkout'
      end
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

  def generate_password
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    (0...8).map{ o[rand(o.length)] }.join
  end

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:destination, :source)
  end

  # TODO REFACTOR THIS
  def load_styles_personalities
    @styles = YAML.load_file(File.join(Rails.root.to_s, 'config', 'styles.yml'))
    @personalities = YAML.load_file(File.join(Rails.root.to_s, 'config', 'personalities.yml'))
    @booked = YAML.load_file(File.join(Rails.root.to_s, 'config', 'booked.yml'))
  end
end