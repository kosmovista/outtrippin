class AdminMailer < ActionMailer::Base
  default from: "\"OutTrippin\" <contact@outtrippin.com>"
  ADMINS = %w(joao@outtrippin.com, indi@outtrippin.com, kunal@outtrippin.com)

  def new_expert_email(user)
    @user = user
    mail to: ADMINS, subject: "[outtrippin.com] new expert registered"
  end
  handle_asynchronously :new_expert_email

  def new_itinerary_email(itinerary)
    @itinerary = itinerary
    mail to: ADMINS, subject: "[outtrippin.com] new itinerary submitted"
  end
  handle_asynchronously :new_itinerary_email

  def payment_received_email(itinerary)
    @itinerary = itinerary
    mail to: ADMINS, subject: "[outtrippin.com] a payment was made"
  end
  handle_asynchronously :payment_received_email
end