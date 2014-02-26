# encoding: UTF-8
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

# TODO: mocks
class GoogleDirectionsTest < Test::Unit::TestCase

  def test_happy_case
    orig = "121 Gordonsville Highway, 37030"
    dest = "499 Gordonsville Highway, 38563"
    directions = GoogleDirections.new(orig, dest)
    assert_equal(4, directions.distance_in_miles)
    assert_equal(5, directions.drive_time_in_minutes)
    assert_equal('http://maps.googleapis.com/maps/api/directions/xml?language=en&alternative=true&sensor=false&mode=driving&origin=121+Gordonsville+Highway%2C+37030&destination=499+Gordonsville+Highway%2C+38563', directions.xml_call)
    # end_location > lat

    assert_equal orig, directions.origin
    assert_equal dest, directions.destination
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

  def test_steps
    directions = GoogleDirections.new("rue poissonnière, 75002 Paris", "51 rue de Turbigo, 75003 Paris France")
    assert_equal Array, directions.steps.class
    assert_equal 5, directions.steps.size
  end

  def test_distance_text
    directions = GoogleDirections.new("Place du Maquis du Vercors PARIS-19EME", "rue poissoniere 75002 paris")
    assert_equal String, directions.distance_text.class
    assert_equal "6.5 km", directions.distance_text
  end

  def test_zero_distance_text
    directions = GoogleDirections.new("27 Beemdenlaan, 2550 Kontich", "499 Gordonsville Highway, 38563")
    assert_equal "0 km", directions.distance_text
  end
end
