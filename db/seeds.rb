require 'csv'

locations = []

CSV.foreach(Rails.root.join('db/seeds/teryt_locations.csv'), headers: true) do |row|
  locations.push([row['GEOM_X'], row['GEOM_Y'], "#{row['﻿ULICA']} #{row['ADR_NR']}"])
end

TerytLocation.import([:geomx, :geomy, :street], locations)

TerytLocationsIndex.delete
TerytLocationsIndex.import
