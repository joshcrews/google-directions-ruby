# Rakefile
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('google_directions', '0.1.6.2') do |p|
  p.description    = "Ruby-wrapper for Google Directions API.  Can return the drive time and driving distance between to places"
  p.url            = "http://github.com/joshcrews/Google-Directions-Ruby"
  p.author         = "Josh Crews"
  p.email          = "josh@joshcrews.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.runtime_dependencies = ['nokogiri >=1.4.1']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }  