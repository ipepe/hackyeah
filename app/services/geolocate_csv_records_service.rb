# rubocop:disable all
class GeolocateCSVRecordsService
  attr_accessor :csv_file, :output

  def initialize(csv_file)
    self.csv_file = csv_file
  end

  def process
    lines = csv_file.read.split("\n")
    headers = lines.unshift.split(';')
    address_name_headers = ['Adres', 'UL', 'NR_BUD']
    lines.each do |line|
      # address string = join by address_name_headers
      # x, y = TerytLocations.find_address(address_string)
    end
    @output = nil # TODO: real output
  end
end
