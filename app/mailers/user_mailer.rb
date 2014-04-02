class UserMailer < ActionMailer::Base
  helper ActionView::Helpers::UrlHelper
  default from: "\"Zuji\" <planmytrip@zuji.com.au>"

  def welcome_expert_email(user)
    @user = user
    mail to: @user.email, subject: "Welcome to Zuji!"
  end

  def welcome_user_email(user, password, itinerary)
    @user = user
    @password = password
    @itinerary = itinerary
    if @itinerary.extra_info.has_key?(:source)
      mail to: @user.email, subject: "Welcome to Zuji!", from: "\"Zuji\" <planmytrip@zuji.com.au>", delivery_method_options: zuji_smtp_settings
    else
      mail to: @user.email, subject: "Welcome to OutTrippin!"
    end
  end

  def payment_received_email(user, itinerary)
    @user = user
    @itinerary = itinerary
    if @itinerary.extra_info.has_key?(:source)
      mail to: @user.email, subject: "Thanks for submitting your Zuji trip and payment.", from: "\"Zuji\" <planmytrip@zuji.com.au>", delivery_method_options: zuji_smtp_settings
    else
      mail to: @user.email, subject: "Thanks for submitting your OutTrippin trip and payment."
    end
  end

  def password_reset_instructions_email(user)
    @user = user
    @reset_url = "http://planmytrip.zuji.com.au/password_resets/#{@user.perishable_token}/edit"
    mail to: @user.email, subject: "Zuji Password Reset Instructions"
  end

  def new_pitch_email(pitch)
    @pitch = pitch
    @itinerary = @pitch.itinerary
    @user = @itinerary.user
    mail to: @user.email, subject: "New Zuji Pitch Received!"
  end

  def new_pitch_email(pitch)
    @pitch = pitch
    @itinerary = @pitch.itinerary
    @user = @itinerary.user
    mail to: @user.email, subject: "New Zuji Pitch Received!"
  end

  def new_pitch_expert_email(pitch)
    @pitch = pitch
    @itinerary = @pitch.itinerary
    @expert = @pitch.user
    mail to: @expert.email, subject: "Your New OutTrippin Pitch Received!"
  end


  def winner_expert_email(pitch)
    @pitch = pitch
    @expert = @pitch.user
    @itinerary = @pitch.itinerary
    mail to: @expert.email, subject: "Woohoo! Your Travel Story concept has been chosen."
  end

  def email_sharer_email(destination, message, itinerary)
    @destination = destination
    @message = message
    @itinerary = itinerary
    @user = @itinerary.user
    mail to: @destination, subject: "Help me plan my next trip on Zuji"
  end

  def new_pitch_email(pitch)
    @pitch = pitch
    @itinerary = @pitch.itinerary
    @user = @itinerary.user

    if @itinerary.extra_info.has_key?(:source)
      mail to: @user.email, subject: "New Zuji Pitch Received!", from: "\"Zuji\" <planmytrip@zuji.com.au>", delivery_method_options: zuji_smtp_settings
    else
      mail to: @user.email, subject: "New OutTrippin Pitch Received!"
    end
  end
end