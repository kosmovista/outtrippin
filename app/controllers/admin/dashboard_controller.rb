class Admin::DashboardController < ApplicationController
  before_action :authorize

  def index

  end

  private

  def authorize
    redirect_to root_path unless current_user && current_user.is?("admin")
  end
end