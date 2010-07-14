require 'test_helper'

class GoogleDirectionsTest < Test::Unit::TestCase

  def test_the_truth
    assert true
  end
  
  def test_happy_case
    directions = GoogleDirections.new("121 Gordonsville Highway, 37030", "499 Gordonsville Highway, 38563")
    assert_equal(4, directions.distance_in_miles)
    assert_equal(6, directions.drive_time_in_minutes)
      assert_equal("http://maps.google.com/maps/api/directions/xml?key=ABQIAAAAj_VbPHmedky6mQd2p37p9xQbL-Ke6g7EfeqhfwcS7ZnhWLsBVxQA3yWKTKM9MVa31hYIhxsKffu7Pw&sensor=false&origin=121+Gordonsville+Highway,+37030&destination=499+Gordonsville+Highway,+38563", directions.xml_call)
    assert_not_nil(directions.xml =~ /36\.1773300/)
  end
  
  def test_directions_not_found
    directions = GoogleDirections.new("fasfefasdfdfsd", "499 Gordonsville Highway, 38563")
    assert_equal(0, directions.distance_in_miles)
    assert_equal(0, directions.drive_time_in_minutes)
    assert_equal("NOT_FOUND", directions.status)
  end
  
  
end
