class PlansController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_itinerary
  before_action :set_plan

  def show
    begin
    if @plan.nil?
      @plan = @itinerary.plans.create(user: @itinerary.winner_pitch.user)
    end
  rescue
    flash[:notice] = "This itinerary doesn't have a winner yet."
    redirect_to itinerary_path(@itinerary)
  end
  end

  def add_day
    day = { title: params[:title], body: params[:body], id: (0...8).map { (65 + rand(26)).chr }.join }
    @plan.days << day
    @plan.save!
    respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @plan }
    end
  end

  def update_day
    @plan.days.each do |d|
      if d[:id] == params[:day_id]
        d[:title] = params[:title]
        d[:body] = params[:body]
      end
    end
    @plan.save!
    respond_to do |format|
      format.json { render json: @plan }
    end
  end

  def delete_day
    @plan.days.delete_if { |d| d[:id] == params[:day_id] }
    @plan.save!

    respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @plan }
    end
  end

  def add_picture
    picture = Picture.create
    picture.source = params[:file]

    # IT IT A COVER PIC?
    if params[:cover] == "true"
      @plan.pictures.each { |p|
        p.cover = false
        p.save
      }
      picture.cover = true
    end
    picture.save

    # IS IT A DAY PIC?
    day = @plan.days.select {|d| d[:id] == params[:day]}
    unless day.first.nil?
      day.first[:picture] = picture.source.url.to_s
    end

    @plan.pictures << picture
    @plan.save!
    respond_to do |format|
      format.json { render json: picture }
    end
  end

  def delete_picture
    @plan.pictures.find_by_id(params[:picture_id].to_i).delete

    respond_to do |format|
      format.json { render 'show' }
    end
  end

  def add_tip_trick
    tip_trick = { title: params[:title], body: params[:body], id: (0...8).map { (65 + rand(26)).chr }.join }
    @plan.tips_tricks << tip_trick
    @plan.save!
    respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @plan }
    end
  end

  def update_tip_trick
    @plan.tips_tricks.each do |tt|
      if tt[:id] == params[:tip_trick_id]
        tt[:title] = params[:title]
        tt[:body] = params[:body]
      end
    end
    @plan.save!
    respond_to do |format|
      format.json { render json: @plan }
    end
  end

  def delete_tip_trick
    @plan.tips_tricks.delete_if { |tt| tt[:id] == params[:tip_trick_id] }
    @plan.save!

    respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @plan }
    end
  end

  # BOOKING ##########
  def add_booking
    booking = { title: params[:title], body: params[:body], id: (0...8).map { (65 + rand(26)).chr }.join, price: params[:price], location: params[:location], link: params[:link] }
    @plan.bookings << booking
    @plan.save!
    respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @plan }
    end
  end

  def update_booking
    @plan.bookings.each do |bk|
      if bk[:id] == params[:booking_id]
        bk[:title] = params[:title]
        bk[:body] = params[:body]
        bk[:price] = params[:price]
        bk[:location] = params[:location]
        bk[:link] = params[:link]
      end
    end
    @plan.save!
    respond_to do |format|
      format.json { render json: @plan }
    end
  end

  def delete_booking
    @plan.bookings.delete_if { |bk| bk[:id] == params[:booking_id] }
    @plan.save!

    respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @plan }
    end
  end

  def add_picture_booking
    picture = Picture.create
    picture.source = params[:file]

    # IS IT A DAY PIC?
    booking = @plan.bookings.select {|bk| bk[:id] == params[:booking]}
    unless booking.first.nil?
      booking.first[:picture] = picture.source.url.to_s
    end

    @plan.save!
    respond_to do |format|
      format.json { render json: @plan }
    end
  end


  private
    def set_itinerary
      @itinerary = Itinerary.find(params[:itinerary_id])
    end

    def set_plan
      # TODO: VALIDATE IF ADMIN OR OWNER
      @plan = @itinerary.plans.first
    end
end