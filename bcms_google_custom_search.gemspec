# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bcms_google_custom_search}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["3months - Kim Chirnside"]
  s.date = %q{2010-01-22}
  s.description = %q{A Google Custom Search Module for BrowserCMS}
  s.email = %q{blackadmin@3months.com}
  s.extra_rdoc_files = [
     "README.markdown"
  ]
  s.files += Dir["app/**/*"]
  s.files += Dir["lib/bcms_google_custom_search.rb"]
  s.files += Dir["lib/bcms_google_custom_search/*"]
  s.files += Dir["rails/init.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://www.3months.com}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A Google Custom Search Module for BrowserCMS}
  s.test_files = []

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.3.0') then
    else
    end
  else
  end
end
