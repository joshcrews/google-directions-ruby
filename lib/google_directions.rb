require 'net/http'
require 'nokogiri'
require 'google_directions'

class GoogleDirections
  
  GOOGLE_MAPS_API_KEY = "ABQIAAAAj_VbPHmedky6mQd2p37p9xQbL-Ke6g7EfeqhfwcS7ZnhWLsBVxQA3yWKTKM9MVa31hYIhxsKffu7Pw"
  
  def initialize(location_1, location_2)
    @base_url = "http://maps.google.com/maps/api/directions/xml?key=#{GOOGLE_MAPS_API_KEY}&sensor=false&"
    @location_1 = location_1
    @location_2 = location_2
  end
  
 # an example URL to be generated
 #http://maps.google.com/maps/api/directions/xml?origin=St.+Louis,+MO&destination=Nashville,+TN&sensor=false&key=ABQIAAAAINgf4OmAIbIdWblvypOUhxSQ8yY-fgrep0oj4uKpavE300Q6ExQlxB7SCyrAg2evsxwAsak4D0Liiv
 
   def xml
     full_url = xml_call
     @xml = get_url(full_url)
   end
  
    def xml_call
      options = "origin=#{transcribe(@location_1)}&destination=#{transcribe(@location_2)}"
      full_url = @base_url + options
    end
    
    def drive_time_in_minutes
      @xml ||= xml
      doc = Nokogiri::XML(@xml)
      raise "Google returned nothing" if doc.nil?
      debugger if drive_time = doc.css("duration value").last.nil?
      drive_time = doc.css("duration value").last.text
      convert_to_minutes(drive_time)
    end

    def distance_in_miles
      @xml ||= xml
      doc = Nokogiri::XML(xml)
      meters = doc.css("distance value").last.text
      miles = (meters.to_f / 1610.22).round
      miles
    end
    
  private
  
    def convert_to_minutes(text)
      (text.to_i / 60).ceil
    end
  
    def transcribe(location)
      location.gsub(" ", "+")
    end

    def get_url(url)
      Net::HTTP.get(::URI.parse(url))
    end
  
end