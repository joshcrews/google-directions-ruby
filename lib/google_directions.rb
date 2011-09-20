# encoding: UTF-8
require 'cgi'
require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'extlib/hash'

class GoogleDirections

  attr_reader :status, :doc, :xml

  @@base_url = 'http://maps.googleapis.com/maps/api/directions/xml'

  def initialize(origin, destination, opts={:language => :en, :alternative => :true, :sensor => :false, :mode => :driving})
    @origin = transcribe(origin)
    @destination = transcribe(destination)
    options = opts.merge({:origin => @origin, :destination => @destination})

    @url = @@base_url + '?' + options.to_params
    @xml = open(@url).read
    @doc = Nokogiri::XML(@xml)
    @status = @doc.css('status').text
  end

  def xml_call
    @url
  end

  # an example URL to be generated
  #http://maps.google.com/maps/api/directions/xml?origin=St.+Louis,+MO&destination=Nashville,+TN&sensor=false&key=ABQIAAAAINgf4OmAIbIdWblvypOUhxSQ8yY-fgrep0oj4uKpavE300Q6ExQlxB7SCyrAg2evsxwAsak4D0Liiv

  def drive_time_in_minutes
    if @status != "OK"
      drive_time = 0
    else
      drive_time = @doc.css("duration value").last.text
      convert_to_minutes(drive_time)
    end
  end

  def distance_in_miles
    if @status != "OK"
      distance_in_miles = 0
    else
      meters = @doc.css("distance value").last.text
      distance_in_miles = (meters.to_f / 1610.22).round
      distance_in_miles
    end
  end


  def steps
    if @status == 'OK'
      @doc.css('html_instructions').map {|a| a.text }
    else
      []
    end
  end

  private

    def convert_to_minutes(text)
      (text.to_f / 60).round
    end

    def transcribe(location)
      CGI::escape(location)
    end

end
