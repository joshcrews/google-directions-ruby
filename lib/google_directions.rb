# encoding: UTF-8
require 'cgi'
require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'openssl'
require 'base64'

class GoogleDirections
  VERSION   = '0.1.6.3'
  BASE_URL  = 'http://maps.googleapis.com'
  BASE_PATH = '/maps/api/directions/xml'
  DEFAULT_OPTIONS = {
    :language => :en,
    :alternative => :true,
    :sensor => :false,
    :mode => :driving,
  }

  attr_reader :status, :doc, :xml, :origin, :destination, :options

  def initialize(origin, destination, opts=DEFAULT_OPTIONS)
    @origin = origin
    @destination = destination
    @options = opts.merge({:origin => @origin, :destination => @destination})
    path = BASE_PATH + '?' + querify(@options)
    @url = BASE_URL + sign_path(path, @options)
    @xml = open(@url).read
    @doc = Nokogiri::XML(@xml)
    @status = @doc.css('status').text
  end

  def xml_call
    @url
  end

  def drive_time_in_minutes
    unless successful?
      drive_time = 0
    else
      drive_time = @doc.css("duration value").last.text
      convert_to_minutes(drive_time)
    end
  end

  # the distance.value field always contains a value expressed in meters.
  def distance
    return @distance if @distance
    unless successful?
      @distance = 0
    else
      @distance = @doc.css("distance value").last.text
    end
  end

  def distance_text
    return @distance_text if @distance_text
    unless successful?
      @distance_text = "0 km"
    else
      @distance_text = @doc.css("distance text").last.text
    end
  end

  def distance_in_miles
    unless successful?
      distance_in_miles = 0
    else
      meters = distance
      distance_in_miles = (meters.to_f / 1610.22).round
      distance_in_miles
    end
  end

  def successful?
    @status == "OK"
  end

  def public_url
    "http://maps.google.com/maps?saddr=#{transcribe(@origin)}&daddr=#{transcribe(@destination)}&hl=#{@options[:language]}&ie=UTF8"
  end

  def steps
    if successful?
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

    def querify(options)
      params = []

      options.each do |k, v|
        params << "#{transcribe(k.to_s)}=#{transcribe(v.to_s)}" unless k == :private_key
      end

      params.join("&")
    end

    def sign_path(path, options)
      return path unless options[:private_key]

      raw_private_key = url_safe_base64_decode(options[:private_key])
      digest = OpenSSL::Digest.new('sha1')
      raw_signature = OpenSSL::HMAC.digest(digest, raw_private_key, path)
      path + "&signature=#{url_safe_base64_encode(raw_signature)}"
    end

    def url_safe_base64_decode(base64_string)
      Base64.decode64(base64_string.tr('-_', '+/'))
    end

    def url_safe_base64_encode(raw)
      Base64.encode64(raw).tr('+/', '-_').strip
    end

end
