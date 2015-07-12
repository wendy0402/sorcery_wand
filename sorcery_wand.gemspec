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
  s.summary     = "SorceryWand is a features plugin for Sorcery gem"
  s.description = "SorceryWand is a features plugin for Sorcery gem such as password archivable"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "sorcery", ">=0.9.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec", '>=3.0'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'ammeter'
  s.add_development_dependency 'looksee'
end
