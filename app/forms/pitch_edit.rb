class PitchEdit
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:title, :summary, :why_me, :pictures]

  attr_accessor *ATTRIBUTES

  def initialize(options = {})
    attributes = options[:attributes]
    @pitch = options[:pitch]
    @itinerary = options[:itinerary]
    @user = options[:user]

    raise ArgumentError, "You need to be an expert" if !@user.is?("expert")
    raise ArgumentError, "You need to supply an itinerary" if @itinerary.nil?
    raise ArgumentError, "You need to supply a pitch" if @pitch.nil?

    unless attributes.nil?
      ATTRIBUTES.each do |attribute|
        send("title=", attributes[:title])
        send("summary=", attributes[:summary])
        send("why_me=", attributes[:why_me])
        send("pictures=", attributes[:pictures])
      end
    else
      send("title=", @pitch.title)
      send("summary=", @pitch.summary)
      send("why_me=", @pitch.why_me)
      send("pictures=", [])
    end
  end

  validate do
    errors[:title] = "Can't be blank" if title.blank?
    errors[:summary] = "Can't be blank" if summary.blank?
    errors[:why_me] = "Can't be blank" if why_me.empty?
    errors[:pictures] = "Can't be blank" if pictures.blank?
  end
  #

  def save
    return false unless valid?
    if update_objects
      AdminMailer.delay.new_pitch_email(@pitch)
      true
    else
      false
    end
  end

  private

  def update_objects
    ActiveRecord::Base.transaction do
      pictures.each do |k, v|
        if v.class == ActionDispatch::Http::UploadedFile
          p = @user.pictures.create(source: v)
          @pitch.pictures << p
          @pitch.save
        end
      end

      @pitch.update_attributes(title: title, summary: summary, why_me: why_me)
    end
  rescue
    false
  end
end