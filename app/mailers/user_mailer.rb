class UserMailer < ActionMailer::Base
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

  def password_reset_instructions_email(user)
    @user = user
    @reset_url = "http://outtrippin.com/password_resets/#{@user.perishable_token}/edit"
    mail to: @user.email, subject: "OutTrippin Password Reset Instructions"
  end
end
