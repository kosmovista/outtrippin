FactoryGirl.define do
  factory :itinerary do |i|
    i.pitches {|p| [p.association(:pitch), p.association(:pitch)]}
    i.destination "Lorem Destination"
  end

  factory :pitch do
    title "A travel to the moon"
  end

end