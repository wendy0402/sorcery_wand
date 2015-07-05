require 'sorcery'
require File.expand_path('../sorcery_wand/config.rb',__FILE__)
module SorceryWand
  mattr_accessor :config

  def self.configure
    self.config ||= Config.new
    yield(self.config)
  end
end
