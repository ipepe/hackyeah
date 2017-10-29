# rubocop:disable all
require 'csv'

class GeolocateCSVRecordsService
  attr_accessor :csv_file, :output

  def initialize(csv_file)
    self.csv_file = csv_file
  end

  def process
    success = 0
    failure = 0

    Parallel.each(SmarterCSV.process(csv_file, col_sep: ';')) do |row|
      if TerytLocationsIndex.find_address("#{row[:adres]} #{row[:ul]}").nil?
        failure += 1
      else
        success += 1
      end
    end
    @output = [success, failure].tap {|o| puts o.inspect }

  end
end
