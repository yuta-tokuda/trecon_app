# -*- encoding: utf-8 -*-
# stub: active_decorator 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "active_decorator".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Akira Matsuda".freeze]
  s.date = "2019-04-01"
  s.description = "A simple and Rubyish view helper for Rails".freeze
  s.email = ["ronnie@dio.jp".freeze]
  s.homepage = "https://github.com/amatsuda/active_decorator".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "A simple and Rubyish view helper for Rails".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<test-unit-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<selenium-webdriver>.freeze, [">= 0"])
      s.add_development_dependency(%q<puma>.freeze, [">= 0"])
      s.add_development_dependency(%q<capybara>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["< 1.4"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<jbuilder>.freeze, [">= 0"])
    else
      s.add_dependency(%q<test-unit-rails>.freeze, [">= 0"])
      s.add_dependency(%q<selenium-webdriver>.freeze, [">= 0"])
      s.add_dependency(%q<puma>.freeze, [">= 0"])
      s.add_dependency(%q<capybara>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, ["< 1.4"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<jbuilder>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<test-unit-rails>.freeze, [">= 0"])
    s.add_dependency(%q<selenium-webdriver>.freeze, [">= 0"])
    s.add_dependency(%q<puma>.freeze, [">= 0"])
    s.add_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, ["< 1.4"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<jbuilder>.freeze, [">= 0"])
  end
end
