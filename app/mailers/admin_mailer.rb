class AdminMailer < ActionMailer::Base
  default from: "\"OutTrippin\" <contact@outtrippin.com>"
  ADMINS = %w(joao@outtrippin.com, indi@outtrippin.com, kunal@outtrippin.com)

  def new_expert_email(user)
    @user = user
    mail to: ADMINS, subject: "[outtrippin.com] new expert registered"
  end

  def new_itinerary_email(itinerary)
    @itinerary = itinerary
    @user = @itinerary.user
    mail to: ADMINS, subject: "[outtrippin.com] new itinerary submitted"
  end

  def payment_received_email(itinerary)
    @itinerary = itinerary
    mail to: ADMINS, subject: "[outtrippin.com] a payment was made"
  end

  def new_pitch_email(pitch)
    @pitch = pitch
    @itinerary = @pitch.itinerary
    @user = @pitch.user
    mail to: ADMINS, subject: "[outtrippin.com] new pitch added"
  end

  def winner_expert_email(pitch)
    @pitch = pitch
    @expert = @pitch.user
    @itinerary = @pitch.itinerary
    @user = @itinerary.user
    mail to: ADMINS, subject: "[outtrippin.com] An Expert was Picked!"
  end

  def plan_is_ready_email(plan)
    @plan = plan
    @itinerary = @plan.itinerary
    mail to: ADMINS, subject: "[outtrippin.com] A Story is ready for the customer!"
  end
end