# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{restaurant_week_boston}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gabe Berke-Williams"]
  s.date = %q{2010-08-14}
  s.summary= %q{A fast, easy way to search the Boston Restaurant Week site and mark your favorites.}
  s.description = %q{A fast, easy way to search the Boston Restaurant Week site and mark your favorites.}
  s.email = %q{gbw@brandeis.edu}
  s.extra_rdoc_files = ["README.rdoc"]
  s.executables = ["restaurant_week_boston"]
  s.default_executable = %q{restaurant_week_boston}
  s.files = [
     "ChangeLog",
     "LICENSE",
     "README.rdoc",
     "bin/restaurant_week_boston",
     "lib/restaurant_week_boston.rb",
     "lib/restaurant_week_boston/scraper.rb",
     "lib/restaurant_week_boston/marker.rb",
     "lib/restaurant_week_boston/restaurant.rb",
     "lib/restaurant_week_boston/runner.rb",
     "restaurant_week_boston.gemspec"
  ]
  s.homepage = %q{http://github.com/gabebw/restaurant_week_boston}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.test_files = []

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
  end

  s.add_dependency(%q<nokogiri>, [">= 1.4.3.0"])
end

