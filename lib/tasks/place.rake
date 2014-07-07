require 'rake'
namespace :places do
  desc "Create new places based on the existing pitches"
  task :create => :environment do
    Pitch.all.each do |p|
      unless p.itinerary.nil?
        destination = p.itinerary.destination

        unless destination.nil?
          sanitized_destination = destination.downcase.strip

          place = Place.find_by_name(sanitized_destination)
          if place.nil?
            puts "\nCREATED\n"
            place = Place.create(name: sanitized_destination)
          else
            puts "\nFOUND\n"
          end
          p.place_id = place.id
          p.save!
        end
      end
    end
  end
end