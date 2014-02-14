class Api::V1::UserSessionsController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token # TODO remove THIS before PRODUCTION

  def create
    user_session = UserSession.new(email: params[:email], password: params[:password])
    if user_session && user_session.save
      render json: { token: current_user.single_access_token }, status: 201
    else
      render json: { message: "Could not authenticate", errors: user_session.errors.full_messages }, status: 401
    end
  end

  # def create
  #   # ember-auth will send either 'email' + 'password' or 'remember_token'
  #   if (params[:email].blank? || params[:password].blank?) && params[:remember_token].blank?
  #     render :json => {}, :status => 400 and return
  #   end
  #
  #   # the user is still authenticated in the ember app
  #   if params[:remember_token].present?
  #     user = User.find_by_single_access_token(params[:remember_token])
  #     user_session = UserSession.create(user) unless user.blank?
  #   else
  #     user_session = UserSession.new(:email => params[:email], :password => params[:password])
  #   end
  #
  #   if user_session && user_session.save
  #     # reset their single access token
  #     current_user.reset_single_access_token! unless params[:remember_token].present?
  #     data = {
  #       :auth_token => current_user.single_access_token,
  #       :user_id => current_user.id
  #     }
  #     if params[:remember_me]
  #       data[:remember_token] = current_user.single_access_token
  #     end
  #     # I'm only using user_session to authenticate them the first time
  #     # we don't want Authlogic persisting the user session
  #     user_session.destroy
  #
  #     # return 'auth_token', 'user_id', and 'remember_token' (if they checked "remember me")
  #     render :json => data, :status => 201
  #   else
  #     render :json => {}, :status => 401
  #   end
  # end
  #
  # def destroy
  #   if current_user
  #     current_user.reset_single_access_token!
  #     render :json => {:user_id => current_user.id}, :status => 200
  #   else
  #     render :json => {}, :status => 400
  #   end
  # end
end