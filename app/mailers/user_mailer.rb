class UserMailer < ActionMailer::Base
  default from: "\"OutTrippin\" <contact@outtrippin.com>"

  def welcome_expert_email(user)
    @user = user
    mail to: @user.email, subject: "Welcome to OutTrippin!"
  end
  handle_asynchronously :welcome_expert_email

  def welcome_user_email(user, password)
    @user = user
    @password = password
    mail to: @user.email, subject: "Welcome to OutTrippin!"
  end
  handle_asynchronously :welcome_user_email

  def password_reset_instructions_email(user)
    @user = user
    @reset_url = "http://outtrippin.com/password_resets/#{@user.perishable_token}/edit"
    mail to: @user.email, subject: "OutTrippin Password Reset Instructions"
  end
  handle_asynchronously :password_reset_instructions_email
end
