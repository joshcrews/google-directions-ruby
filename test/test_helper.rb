# encoding: UTF-8
require 'rubygems'
require 'mocha'
require 'test/unit'

lib_dir = File.join(File.dirname(__FILE__), '..', 'lib')
$:.unshift(File.expand_path(lib_dir))
require 'google_directions'
