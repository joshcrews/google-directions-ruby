Gem::Specification.new do |s|
  s.name        = 'google_directions'
  s.version     = '0.1.6.3'
  s.date        = '2010-04-28'
  s.summary     = "Ruby-wrapper for Google Directions API"
  s.description = "Ruby-wrapper for Google Directions API. Can return the drive time and driving distance between two places."
  s.authors     = ["Josh Crews"]
  s.email       = 'josh@joshcrews.com'
  s.files       = ["init.rb", "lib/google_directions.rb"]
  s.homepage    = 'https://github.com/joshcrews/google-directions-ruby'
  s.license     = 'MIT'

  s.add_dependency "nokogiri", ">= 1.4.1"

  s.add_development_dependency "mocha"
end
