# -*- encoding: utf-8 -*-
# stub: friendly_routes 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "friendly_routes"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Roman Gritsay"]
  s.date = "2016-09-03"
  s.description = "Friendly routes creates DSL for creating rails routes with human friendly URLs"
  s.email = ["w2@live.ru"]
  s.files = ["MIT-LICENSE", "README.md", "Rakefile", "lib/friendly_routes", "lib/friendly_routes.rb", "lib/friendly_routes/dispatcher.rb", "lib/friendly_routes/helper.rb", "lib/friendly_routes/params", "lib/friendly_routes/params/base.rb", "lib/friendly_routes/params/boolean.rb", "lib/friendly_routes/params/collection.rb", "lib/friendly_routes/route.rb", "lib/friendly_routes/services", "lib/friendly_routes/services/constraints.rb", "lib/friendly_routes/services/parser.rb", "lib/friendly_routes/services/prefixed_param.rb", "lib/friendly_routes/services/prefixed_params.rb", "lib/friendly_routes/version.rb"]
  s.homepage = "https://github.com/RoM4iK/friendly_routes"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Human friendly routes for Rails application"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 0"])
      s.add_development_dependency(%q<rails>, [">= 5.0.0.1", "~> 5.0.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<faker>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<rails>, [">= 5.0.0.1", "~> 5.0.0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<faker>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<rails>, [">= 5.0.0.1", "~> 5.0.0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<factory_girl_rails>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<faker>, [">= 0"])
  end
end
