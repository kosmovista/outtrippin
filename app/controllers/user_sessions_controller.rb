class UserSessionsController < ApplicationController
  def new
    redirect_to root_url unless current_user.blank?
    @user_session = UserSession.new
    unless redirect_params.blank?
      @redir_key, @redir_value = redirect_params.first
    end
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


  private
    def role_login_path
      if redirect_params
        return build_redirection_path
      end
      return admin_path if current_user.is?("admin")
      return root_path
    end

    def build_redirection_path
      # TODO This may have to accomodate more than itineraries
      ap "I'm here!"
      ap redirect_params[:itinerary]
      return itinerary_path(redirect_params[:itinerary])
    end

    def redirect_params
      params.permit(:itinerary)
    end
end