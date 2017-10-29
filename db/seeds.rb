require 'csv'

locations = []

puts 'cleaning database'
TerytLocation.destroy_all
TerytLocationsIndex.delete

puts 'loading csv'
CSV.foreach(Rails.root.join('db/seeds/teryt_locations.csv'), headers: true) do |row|
  locations.push([row['GEOM_X'], row['GEOM_Y'], TerytLocation.clean("#{row['ULICA']} #{row['ADR_NR']}")])
end

puts 'importing csv'
TerytLocation.import([:geomx, :geomy, :street], locations)

puts 'creating indexes'
TerytLocationsIndex.import

puts 'done'