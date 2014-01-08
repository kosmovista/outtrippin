class PasswordResetsController < ApplicationController
  before_action :load_user_using_perishable_token, only: [:edit, :update]

  def new

  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.reset_perishable_token!
      UserMailer.delay.password_reset_instructions_email(@user)
      flash[:notice] = "Instructions to reset your password have been emailed to you. Please check your email."
      redirect_to root_url
    else
      flash[:notice] = "No user was found with that email address."
      render 'new'
    end
  end

  def edit
    @token = params[:id]
  end

  def update
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      flash[:notice] = "Password successfully updated."
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:notice] = "We're sorry, but we could not locate your account. " +
      "If you are having issues try copying and pasting the URL " +
      "from your email into your browser or restarting the " +
      "reset password process."
      redirect_to new_password_reset_path
    end
  end
end