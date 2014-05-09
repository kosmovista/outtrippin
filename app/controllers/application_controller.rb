class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def browsexperimental
    @itinerary = Itinerary.new
    render layout: 'new_application'
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  ##
  # detects if default or honeymoon should be presented
  ##
  def set_homepage_type
    begin
      s = request.original_url.to_s.sub(/^https?\:\/\//, '').sub(/^www./,'').sub(/\/$/, '').split(".")
      if s.include?("honeymoon") || s.include("honeymoons")
        @homepage_type = "honeymoon"
      else
        @homepage_type = "default"
      end
    end
  rescue
    @homepage_type = "default"
  end

  private

  def store_location
    session[:original_uri] = request.url
  end

  def authorize_user
    unless current_user
      session[:original_uri] = request.url
      flash[:notice] = "Howdy! You must login to access this page!"
      redirect_to login_path
    end
  end

  def authorize_expert
    authorize_user
  end

  def authorize_owner
    redirect_to root_path unless current_user == @user || (current_user && current_user.admin?)
  end

  def authorize_admin
    redirect_to root_path unless current_user && current_user.admin?
  end

  def set_white_topbar
    @white_topbar = true
  end
end