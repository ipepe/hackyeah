require_relative '../test_helper'

class GeolocateCSVRecordsServiceTest < ActiveSupport::TestCase
  test 'the truth' do
    service = GeolocateCSVRecordsService.new(Rails.root.join('test', 'fixtures', 'test-input.csv'))
    refute_nil service.csv_file
    service.process
    assert_nil service.output # TODO, return real CSV
  end
end
