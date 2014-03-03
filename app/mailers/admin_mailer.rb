class AdminMailer < ActionMailer::Base
  default from: "\"OutTrippin\" <contact@outtrippin.com>"
  ADMINS = %w(joao@outtrippin.com, indi@outtrippin.com, kunal@outtrippin.com)

  def new_expert_email(user)
    @user = user
    mail to: ADMINS, subject: "[PlanMyTrip] new expert registered"
  end

  def new_itinerary_email(itinerary)
    @itinerary = itinerary
    mail to: ADMINS, subject: "[PlanMyTrip] new itinerary submitted"
  end

  def payment_received_email(itinerary)
    @itinerary = itinerary
    mail to: ADMINS, subject: "[PlanMyTrip] a payment was made"
  end

  def new_pitch_email(pitch)
    @pitch = pitch
    @itinerary = @pitch.itinerary
    @user = @pitch.user
    mail to: ADMINS, subject: "[PlanMyTrip] new pitch added"
  end

  def winner_expert_email(pitch)
    @pitch = pitch
    @expert = @pitch.user
    @itinerary = @pitch.itinerary
    @user = @itinerary.user
    mail to: ADMINS, subject: "[PlanMyTrip] An Expert was Picked!"
  end
end