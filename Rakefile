# Rakefile
require 'rubygems'
require 'rake'
require 'echoe'

require 'rake/testtask'
require 'minitest'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/unit/*_test.rb']
  t.verbose = true
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
