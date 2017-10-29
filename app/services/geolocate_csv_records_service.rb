# rubocop:disable all
require 'csv'

class GeolocateCSVRecordsService
  attr_accessor :csv_file, :output

  def initialize(csv_file)
    self.csv_file = csv_file
    self.output = {}
  end

  def process
    success = 0
    failure = 0

    self.output[:result] = Parallel.map(SmarterCSV.process(csv_file, col_sep: ';', chunk_size: 500)) do |chunk|
      chunk.map do |row|
        address = TerytLocationsIndex.find_address(TerytLocation.clean("#{row[:adres]} #{row[:ul]}"))
        if address.present?
          row[:address_id] = address.id
          row[:address_found] = address.street
        end
        row
      end
    end.flatten

    self.output[:success] = success
    self.output[:failure] = failure
    self.output
  end
end
