# -*- encoding: utf-8 -*-
# stub: pry-byebug 1.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "pry-byebug".freeze
  s.version = "1.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Rodr\u{ed}guez".freeze, "Gopal Patel".freeze]
  s.date = "2014-02-24"
  s.description = "Combine 'pry' with 'byebug'. Adds 'step', 'next', and\n    'continue' commands to control execution.".freeze
  s.email = "deivid.rodriguez@gmail.com".freeze
  s.homepage = "https://github.com/deivid-rodriguez/pry-byebug".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Fast debugging with Pry.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pry>.freeze, ["~> 0.9.12"])
      s.add_runtime_dependency(%q<byebug>.freeze, ["~> 2.7"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.5"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.1"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 1.0"])
    else
      s.add_dependency(%q<pry>.freeze, ["~> 0.9.12"])
      s.add_dependency(%q<byebug>.freeze, ["~> 2.7"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.1"])
      s.add_dependency(%q<mocha>.freeze, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<pry>.freeze, ["~> 0.9.12"])
    s.add_dependency(%q<byebug>.freeze, ["~> 2.7"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.1"])
    s.add_dependency(%q<mocha>.freeze, ["~> 1.0"])
  end
end
