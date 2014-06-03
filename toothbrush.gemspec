# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "toothbrush"
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rodrigo Manh\u{e3}es"]
  s.date = "2013-02-23"
  s.description = "Useful stuff for testing with Capybara"
  s.email = "rmanhaes@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/toothbrush.rb",
    "lib/toothbrush/helpers.rb",
    "spec/dummy_app/app.rb",
    "spec/dummy_app/page.html",
    "spec/spec_helper.rb",
    "spec/toothbrush_spec.rb",
    "toothbrush.gemspec"
  ]
  s.homepage = "http://github.com/rodrigomanhaes/toothbrush"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.summary = "Useful stuff for testing with Capybara"

  s.add_dependency('text-table')
  s.add_development_dependency('rspec', '>= 2.11.0')
  s.add_development_dependency('sinatra', '>= 0')
  s.add_development_dependency('capybara', '>= 1.0')
  s.add_development_dependency('pry-rails')
end
