class PitchNew
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:title, :summary, :why_me, :pic_1, :pic_2, :pic_3]

  attr_accessor *ATTRIBUTES

  def initialize(options = {})
    attributes = options[:attributes]
    @itinerary = options[:itinerary]
    @user = options[:user]

    raise ArgumentError, "You need to be an expert" if !@user.is?("expert")
    raise ArgumentError, "You need to supply an itinerary" if @itinerary.nil?

    unless attributes.nil?
      ATTRIBUTES.each do |attribute|
        send("#{attribute}=", attributes[attribute])
      end
    end
  end

  validate do
    errors[:title] = "Can't be blank" if title.blank?
    errors[:summary] = "Can't be blank" if summary.blank?
    errors[:why_me] = "Can't be blank" if why_me.empty?
  end
  #
  def pitch
    @pitch ||= Pitch.new(title: title, summary: summary, why_me: why_me)
  end
  #
  def save
    return false unless valid?
    if create_objects
      true
    else
      false
    end
  end


  private

  def create_objects
    # ActiveRecord::Base.transaction do
    pitch.user = @user
    pitch.save!
    @itinerary.pitches << pitch
    @itinerary.save!
  #   end
  # rescue
  #   false
  end

end