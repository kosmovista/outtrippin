require 'rake'
namespace :itineraries do
  task :all_to_csv => :environment do
    puts "exporting all tasks"
    f = File.new("itineraries.csv", 'w+')
    Itinerary.all.each do |i|
      if i.user.blank?
        f << "nil;"
      else
        f << "#{i.user.email};"
      end

      if i.duration.blank?
        f << "nil;"
      else
        f << "#{i.duration};"
      end

      if i.departure.blank?
        f << "nil;\n"
      else
        f << "#{i.departure};\n"
      end
    end
    f.close
  end
end