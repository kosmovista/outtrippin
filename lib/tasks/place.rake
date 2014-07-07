require 'rake'
namespace :places do
  desc "Create new places based on the existing pitches"
  task :create => :environment do
    Pitch.all.each do |p|
      destination = p.itinerary.destination
      destination.downcase!.strip!

      place = Place.find_by_name(destination)
      if place.nil?
        place = Place.create(name: destination)
      end
      p.place_id = place.id
      p.save!
    end
  end
end