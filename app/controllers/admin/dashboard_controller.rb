class Admin::DashboardController < ApplicationController
  before_action :authorize_admin

  def index

  end

  def expert_list
    @experts = User.experts
    respond_to do |format|
      format.xls
    end
  end
end