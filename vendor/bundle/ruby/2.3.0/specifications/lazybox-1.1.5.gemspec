# -*- encoding: utf-8 -*-
# stub: lazybox 1.1.5 ruby lib

Gem::Specification.new do |s|
  s.name = "lazybox".freeze
  s.version = "1.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alex Galushka".freeze]
  s.date = "2015-03-17"
  s.description = "Lazybox is a jQuery-based, lightbox that can display entire remote pages, images and confirmation dialogs. Replace standard rails confirmations with lazybox just added several rows to your project. Use lazybox with rails assets pipeline.".freeze
  s.email = ["sexmcs@gmail.com".freeze]
  s.homepage = "https://github.com/galulex/lazybox".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Use LazyBox for popup windows with Rails".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<jquery-rails>.freeze, [">= 0"])
    else
      s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
  end
end
