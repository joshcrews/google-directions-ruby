# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{google_directions}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Crews"]
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  s.description = %q{Ruby-wrapper for Google Directions API.  Can return the drive time and driving distance between to places}
  s.email = %q{josh@joshcrews.com}
  s.extra_rdoc_files = ["README.textile", "lib/google_directions.rb"]
  s.files = Dir["README.textile", "Gemfile", "Rakefile", "google_directions.gemspec", 'init.rb', "test/**/*", "lib/**/*.rb"]
  s.homepage = %q{http://github.com/joshcrews/Google-Directions-Ruby}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Google_directions", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{google_directions}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby-wrapper for Google Directions API.  Can return the drive time and driving distance between to places}
  s.test_files = Dir.glob("test/**/*_test.rb")

  s.add_dependency("nokogiri", ">=1.4.1")
end
