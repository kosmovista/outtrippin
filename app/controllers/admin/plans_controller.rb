class Admin::PlansController < ApplicationController
  before_action :authorize_admin

  def index
  end

  def toggle_published
    @plan = Plan.find(params[:plan_id])
    @plan.published = !@plan.published
    @plan.save
    redirect_to :back
  end

end