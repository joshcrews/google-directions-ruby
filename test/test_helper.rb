require 'rubygems'
require 'mocha'
require 'test/unit'
require 'ruby-debug'

$:.unshift File.expand_path('../lib', __FILE__)
require 'google_directions'

GOOGLE_MAPS_API_KEY = "afakeapithatworksanyway"

