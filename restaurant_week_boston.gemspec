# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restaurant_week_boston/version'

Gem::Specification.new do |s|
  s.name = %q{restaurant_week_boston}
  s.version = RestaurantWeekBoston::VERSION

  s.authors = ["Gabe Berke-Williams"]
  s.summary= 'A fast, easy way to search the Boston Restaurant Week site and mark your favorites.'
  s.email = 'gabebw@gabebw.com'

  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.homepage = %q{http://github.com/gabebw/restaurant_week_boston}
  s.require_paths = ["lib"]
  s.test_files = []
  s.license = "MIT"

  s.add_dependency(%q<nokogiri>, [">= 1.4.3.0"])
  s.add_development_dependency "bundler", "~> 1.12"
  s.add_development_dependency "rake", "~> 10.0"
end
