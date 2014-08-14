class PitchNew
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:title, :summary, :why_me, :pictures]

  attr_accessor *ATTRIBUTES

  def initialize(options = {})
    attributes = options[:attributes]
    @itinerary = options[:itinerary]
    @user = options[:user]

    raise ArgumentError, "You need to be an expert" if !@user.is?("expert")
    raise ArgumentError, "You need to supply an itinerary" if @itinerary.nil?

    unless attributes.nil?
      send("title=", attributes[:title])
      send("summary=", attributes[:summary])
      send("why_me=", attributes[:why_me])
      send("pictures=", attributes[:pictures])
    end
  end

  validate do
    errors[:title] = "Can't be blank" if title.blank?
    errors[:summary] = "Can't be blank" if summary.blank?
    errors[:why_me] = "Can't be blank" if why_me.blank?
    errors[:pictures] = "Can't be blank" if pictures.blank?
  end
  #
  def pitch
    @pitch ||= Pitch.new(title: title, summary: summary, why_me: why_me)
  end
  #
  def save
    return false unless valid?
    if create_objects
      UserMailer.delay.new_pitch_email(@pitch)
      UserMailer.delay.new_pitch_expert_email(@pitch)
      AdminMailer.delay.new_pitch_email(@pitch)
      true
    else
      false
    end
  end


  private

  def create_objects
    ActiveRecord::Base.transaction do
      pictures.each do |k, v|
        if v.class == ActionDispatch::Http::UploadedFile
          p = @user.pictures.create(source: v)
          pitch.pictures << p
        end
      end
      @itinerary.pitches << pitch
      @itinerary.save!
      pitch.user = @user
      pitch.save!
    end
  rescue
    false
  end

end