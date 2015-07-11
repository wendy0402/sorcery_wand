require 'sorcery'
require File.expand_path('../sorcery_wand/config.rb', __FILE__)
require File.expand_path('../sorcery_wand/submodules.rb', __FILE__)
require File.expand_path('../sorcery_wand/engine.rb', __FILE__)
require File.expand_path('../sorcery_wand/submodules/password_archivable.rb', __FILE__)
require File.expand_path('../sorcery_wand/submodules/password_archivable/password_archives.rb', __FILE__)

module SorceryWand
  mattr_accessor :config

  def self.configure
    self.config ||= Config.new
    yield(self.config)
  end

  def self.user_class
    self.config.user_class.constantize
  end
end
