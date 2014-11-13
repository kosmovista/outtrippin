object @itinerary
attributes :id, :destination, :departure, :duration, :extra_info
node(:user, :unless => lambda {|itinerary| itinerary.user.nil?}) { |itinerary| { id: itinerary.user.id, email: itinerary.user.email }}
