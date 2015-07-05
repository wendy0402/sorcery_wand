$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sorcery_wand/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sorcery_wand"
  s.version     = SorceryWand::VERSION
  s.authors     = ["wendy0402"]
  s.email       = ["wendykurniawan92@gmail.com"]
  s.homepage    = "https://github.com/wendy0402/sorcery_wand"
  s.summary     = "SorceryWand is a plugin for Sorcery gem for many different features"
  s.description = "SorceryWand is a plugin for Sorcery gem for many different features such as password archivable"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "sorcery", "0.9.1"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec", '>=3.0'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'ammeter'
end
