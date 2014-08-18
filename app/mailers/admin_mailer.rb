class AdminMailer < ActionMailer::Base
  default from: "\"OutTrippin Bot\" <contact@outtrippin.com>"
  ADMINS = %w(joao@outtrippin.com, indi@outtrippin.com, kunal@outtrippin.com)

  def new_expert_email(user)
    @user = user
    mail to: ADMINS, subject: "*New Expert Registered:* #{@user.email} from #{@user.expert_info[:website]}."
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
    mail to: ADMINS, subject: "*An Expert was chosen:* #{@user.email} picked #{@expert.personal_info[:name]} for #{itinerary_url(@itinerary)}"
  end

  def plan_is_ready_email(plan)
    @plan = plan
    @itinerary = @plan.itinerary
    mail to: ADMINS, subject: "[outtrippin.com] A story is ready admin approval"
  end
end