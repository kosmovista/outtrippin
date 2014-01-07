class PlansController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_itinerary

  def show
    @plan = @itinerary.get_plan_from(current_user)
    if @plan.nil?
      @plan = @itinerary.plans.create(user: current_user)
    end
  end

  def add_day
    @plan = @itinerary.get_plan_from(current_user)
    day = { title: params[:title], body: params[:body], id: (0...8).map { (65 + rand(26)).chr }.join }
    @plan.days << day
    @plan.save!
    respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @plan }
    end
  end

  def update_day
    @plan = @itinerary.get_plan_from(current_user)
    @plan.days.each do |d|
      if d[:id] == params[:day_id]
        ap params[:title]
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
    @plan = @itinerary.get_plan_from(current_user)
    @plan.days.delete_if { |d| d[:id] == params[:day_id] }
    @plan.save!

    respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @plan }
    end
  end

  def add_picture
    @plan = @itinerary.get_plan_from(current_user)
    picture = Picture.create
    picture.source = params[:file]
    picture.save
    @plan.pictures << picture
    @plan.save!
    respond_to do |format|
      format.json { render json: picture }
    end
  end

  def delete_picture
    @plan = @itinerary.get_plan_from(current_user)
    @plan.pictures.find_by_id(params[:picture_id].to_i).delete

    respond_to do |format|
      format.json { render 'show' }
    end
  end

  private
    def set_itinerary
      @itinerary = Itinerary.find(params[:itinerary_id])
    end
end