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
end
