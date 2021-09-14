# -*- encoding: utf-8 -*-
# stub: new_super_codebreaker_2021 0.4.9 ruby lib

Gem::Specification.new do |s|
  s.name = "new_super_codebreaker_2021".freeze
  s.version = "0.4.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nazar Dakhno".freeze]
  s.bindir = "exe".freeze
  s.date = "2021-09-14"
  s.description = "Game where you need to guess the secret code".freeze
  s.email = ["dakhnonazar@gmail.com".freeze]
  s.homepage = "https://rubygems.org/gems/new_super_codebreaker_2021".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.2.25".freeze
  s.summary = "New game codebreaker!".freeze

  s.installed_by_version = "3.2.25" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<fasterer>.freeze, ["~> 0.9.0"])
    s.add_development_dependency(%q<ffaker>.freeze, ["~> 2.19.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.10.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.7"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.21.2"])
    s.add_development_dependency(%q<terminal-table>.freeze, ["~> 3.0.1"])
  else
    s.add_dependency(%q<fasterer>.freeze, ["~> 0.9.0"])
    s.add_dependency(%q<ffaker>.freeze, ["~> 2.19.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.10.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 1.7"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.21.2"])
    s.add_dependency(%q<terminal-table>.freeze, ["~> 3.0.1"])
  end
end
