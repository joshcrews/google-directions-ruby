# encoding: UTF-8
require 'net/http'
require 'nokogiri'
require 'google_directions'

class GoogleDirections
  
  def initialize(location_1, location_2)
    @base_url = "http://maps.google.com/maps/api/directions/xml?sensor=false&"
    @location_1 = location_1
    @location_2 = location_2
    options = "origin=#{transcribe(@location_1)}&destination=#{transcribe(@location_2)}"
    @xml_call = @base_url + options
    @status = find_status
  end

  # an example URL to be generated
  #http://maps.google.com/maps/api/directions/xml?origin=St.+Louis,+MO&destination=Nashville,+TN&sensor=false&key=ABQIAAAAINgf4OmAIbIdWblvypOUhxSQ8yY-fgrep0oj4uKpavE300Q6ExQlxB7SCyrAg2evsxwAsak4D0Liiv
  
  def find_status
    doc = Nokogiri::XML(xml)
    doc.css("status").text
  end

  def xml
    unless @xml.nil?
       @xml
    else
      @xml ||= get_url(@xml_call)
    end
  end

  def xml_call
    @xml_call
  end

  def drive_time_in_minutes
    if @status != "OK"
      drive_time = 0
    else
      doc = Nokogiri::XML(xml)
      drive_time = doc.css("duration value").last.text
      convert_to_minutes(drive_time)
    end
  end

  def distance_in_miles
    if @status != "OK"
      distance_in_miles = 0
    else
      doc = Nokogiri::XML(xml)
      meters = doc.css("distance value").last.text
      distance_in_miles = (meters.to_f / 1610.22).round
      distance_in_miles
    end
  end
  
  def status
    @status
  end
    
  private
  
    def convert_to_minutes(text)
      (text.to_f / 60).round
    end
  
    def transcribe(location)
      location.gsub(" ", "+")
    end

    def get_url(url)
      Net::HTTP.get(::URI.parse(url))
    end
  
end
