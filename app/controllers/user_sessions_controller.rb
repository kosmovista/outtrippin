class UserSessionsController < ApplicationController
  def new
    redirect_to root_url unless current_user.blank?
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to calculate_redirect_path
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_url
  end

  private
    def calculate_redirect_path
      uri = session[:original_uri]
      session[:original_uri] = nil
      if uri
        return uri
      else
        return admin_path if current_user.admin?
        return itineraries_path if current_user.expert?
        return root_path
      end
    end
end