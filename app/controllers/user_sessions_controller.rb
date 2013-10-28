class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to root_url
    else
      puts @user_session.errors.inspect
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_url
  end
end