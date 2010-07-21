# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{google_directions}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Crews"]
  s.date = %q{2010-07-20}
  s.description = %q{Ruby-wrapper for Google Directions API.  Can return the drive time and driving distance between to places}
  s.email = %q{josh@joshcrews.com}
  s.extra_rdoc_files = ["README.textile", "lib/google_directions.rb"]
  s.files = ["Manifest", "README.textile", "Rakefile", "google_directions.gemspec", "init.rb", "lib/google_directions.rb", "test/mocks/google_directions_samle_xml.xml", "test/test_helper.rb", "test/unit/google_directions_test.rb"]
  s.homepage = %q{http://github.com/joshcrews/Google-Directions-Ruby}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Google_directions", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{google_directions}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby-wrapper for Google Directions API.  Can return the drive time and driving distance between to places}
  s.test_files = ["test/test_helper.rb", "test/unit/google_directions_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<nokogiri>, [">= 1.4.1"])
    else
      s.add_dependency(%q<nokogiri>, [">= 1.4.1"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 1.4.1"])
  end
end
