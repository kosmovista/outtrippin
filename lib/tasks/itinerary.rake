require 'rake'
namespace :itineraries do
  desc "Export all itineraries"
  task :all_to_csv => :environment do
    puts "exporting all tasks"
    f = File.new("itineraries.csv", 'w+')
    column_names = Itinerary.column_names

    column_names.each do |attribute|
      f << "#{attribute};"
    end

    f << "\n"

    Itinerary.all.each do |i|
      column_names.each do |attribute|
        value = i.read_attribute(attribute)
        value.blank? ? f << "nil;" : f << "#{value};"
      end
      f << "\n"
    end
    f.close
  end
end