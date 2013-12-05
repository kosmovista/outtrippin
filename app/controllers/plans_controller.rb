class PlansController < ApplicationController
  layout 'itineraries'

  before_action :set_itinerary
  def create
    @plan = @itinerary.get_plan_from(current_user)
    if @plan.nil?
      @plan = @itinerary.plans.create(user: current_user)
    end
    render 'edit'
  end

  def add_day
    ap params
  end

  private
    def set_itinerary
      @itinerary = Itinerary.find(params[:itinerary_id])
    end
end