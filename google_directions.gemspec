# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google_directions'

Gem::Specification.new do |s|
  s.name        = 'google_directions'
  s.version     = GoogleDirections::VERSION
  s.summary     = "Ruby-wrapper for Google Directions API"
  s.description = "Ruby-wrapper for Google Directions API. Can return the drive time and driving distance between two places."
  s.authors     = ["Josh Crews"]
  s.email       = 'josh@joshcrews.com'
  s.files       = `git ls-files -z`.split("\x0") 
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})
  s.homepage    = 'https://github.com/joshcrews/google-directions-ruby'
  s.license     = 'MIT'

  s.add_dependency 'nokogiri', '~> 1.4', '>= 1.4.1'
  s.add_development_dependency 'mocha', '~>1.1', '>= 1.1.0'
end
