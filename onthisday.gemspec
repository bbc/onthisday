# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "onthisday"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Lowis"]
  s.date = "2012-09-13"
  s.email = "chris.lowis@gmail.com"
  s.files = ["Gemfile", "README.rdoc", "test/fixtures", "test/fixtures/main_page_20120620.html", "test/fixtures/main_page_20120903.html", "test/fixtures/main_page_20120913.html", "test/onthisday_test.rb", "lib/onthisday.rb"]
  s.homepage = "http://github.com/bbcrd/onthisday"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "A little parser for Wikipedia's 'On This Day' content block"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
  end
end
