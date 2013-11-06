class UserSessionsController < ApplicationController
  def new
    redirect_to root_url unless current_user.blank?
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to role_login_path
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_url
  end

  def role_login_path
    return admin_path if current_user.is?("admin")
    return root_path
  end
end