require 'csv'

locations = []

CSV.foreach(Rails.root.join('db/seeds/teryt_locations.csv'), headers: true) do |row|
  raise 'puste' if row['ADR_NR'].empty?
  locations.push([row['GEOM_X'], row['GEOM_Y'], "#{row['ULICA']} #{row['ADR_NR']}"])
end

TerytLocation.import([:geomx, :geomy, :street], locations)
