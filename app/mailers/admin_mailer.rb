class AdminMailer < ActionMailer::Base
  default from: "\"OutTrippin\" <contact@outtrippin.com>"
  ADMINS = %w(joao@outtrippin.com, indi@outtrippin.com, kunal@outtrippin.com)

  def new_expert_email(user)
    @user = user
    mail to: ADMINS, subject: "[outtrippin.com] new expert registered"
  end
end
