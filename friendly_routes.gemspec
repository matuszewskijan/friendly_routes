# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'friendly_routes/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'friendly_routes'
  s.version     = FriendlyRoutes::VERSION
  s.authors     = ['Roman Gritsay']
  s.email       = ['w2@live.ru']
  s.homepage    = 'https://github.com/RoM4iK/friendly_routes'
  s.summary     = 'Human friendly routes for Rails application'
  s.description = 'Friendly routes creates DSL for creating rails routes with human friendly URLs'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails'

  s.add_development_dependency 'rails', '~> 5.0.0', '>= 5.0.0.1'
  s.add_development_dependency 'sqlite3'
end
