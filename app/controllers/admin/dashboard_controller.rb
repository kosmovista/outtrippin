class Admin::DashboardController < ApplicationController
  before_action :authorize_user
  before_action :authorize_admin

  def index
    if params[:filter] == "experts"
      @users = User.experts.page(params[:page] || 0).per(300)
    elsif params[:filter] == "customers"
      @users = User.customers.page(params[:page] || 0)
    elsif params[:filter] == "admins"
      @users = User.admins.page(params[:page] || 0)
    else
      @users = User.page(params[:page] || 0)
    end
  end

  def expert_list
    @experts = User.experts
    respond_to do |format|
      format.xls
    end
  end
end