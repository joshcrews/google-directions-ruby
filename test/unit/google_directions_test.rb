# encoding: UTF-8
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class GoogleDirectionsTest < Test::Unit::TestCase

  def test_the_truth
    assert true
  end
  
  def test_happy_case
    directions = GoogleDirections.new("121 Gordonsville Highway, 37030", "499 Gordonsville Highway, 38563")
    assert_equal(4, directions.distance_in_miles)
    assert_equal(6, directions.drive_time_in_minutes)
    assert_equal('http://maps.google.com/maps/api/directions/xml?sensor=false&origin=121+Gordonsville+Highway%2C+37030&destination=499+Gordonsville+Highway%2C+38563', directions.xml_call)
    # end_location > lat
    assert_not_nil(directions.xml =~ /36\.1772300/)
  end
  
  def test_directions_not_found
    directions = GoogleDirections.new("fasfefasdfdfsd", "499 Gordonsville Highway, 38563")
    assert_equal(0, directions.distance_in_miles)
    assert_equal(0, directions.drive_time_in_minutes)
    assert_equal("NOT_FOUND", directions.status)
  end
  
  def test_zero_results
    directions = GoogleDirections.new("27 Beemdenlaan, 2550 Kontich", "499 Gordonsville Highway, 38563")
    assert_equal(0, directions.distance_in_miles)
    assert_equal(0, directions.drive_time_in_minutes)
    assert_equal("ZERO_RESULTS", directions.status)
  end

  def test_french_direction
    assert_nothing_raised do
      # URI::InvalidURIError
      directions = GoogleDirections.new("15 rue poissonnière, 75002 Paris", "169 11th Street CA 94103 San Francisco United States")
    end
  end
end
