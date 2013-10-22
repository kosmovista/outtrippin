class ExpertsController < ApplicationController

  def new
    @expert_registration = ExpertRegistration.new
  end

  def create
    @expert_registration = ExpertRegistration.new(params)
    if @expert_registration.save
      redirect_to root_path
    else
      ap @expert_registration
      render 'new'
    end
  end
end
