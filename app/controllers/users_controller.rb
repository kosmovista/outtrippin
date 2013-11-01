class UsersController < ApplicationController
  before_action :authorize_admin
  before_action :set_user

  def show

  end

  def destroy
    # Add some notices.
    @user.delete
    redirect_to :back
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end