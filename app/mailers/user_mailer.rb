class UserMailer < ActionMailer::Base
  helper ActionView::Helpers::UrlHelper
  default from: "\"OutTrippin\" <contact@outtrippin.com>"

  def welcome_expert_email(user)
    @user = user
    mail to: @user.email, subject: "Welcome to OutTrippin!"
  end

  def welcome_user_email(user, password)
    @user = user
    @password = password
    mail to: @user.email, subject: "Welcome to OutTrippin!"
  end

  def payment_received_email(user, itinerary)
    @user = user
    @itinerary = itinerary
    mail to: @user.email, subject: "Thanks for submitting your OutTrippin trip and payment."
  end

  def password_reset_instructions_email(user)
    @user = user
    @reset_url = "http://outtrippin.com/password_resets/#{@user.perishable_token}/edit"
    mail to: @user.email, subject: "OutTrippin Password Reset Instructions"
  end

  def new_pitch_email(pitch)
    @pitch = pitch
    @itinerary = @pitch.itinerary
    @user = @itinerary.user
    mail to: @user.email, subject: "New OutTrippin Pitch Received!"
  end

  def new_pitch_email(pitch)
    @pitch = pitch
    @itinerary = @pitch.itinerary
    @user = @itinerary.user
    mail to: @user.email, subject: "New OutTrippin Pitch Received!"
  end

  def winner_expert_email(pitch)
    @pitch = pitch
    @expert = @pitch.user
    @itinerary = @pitch.itinerary
    mail to: @expert.email, subject: "Congratulations, you've been picked"
  end
end