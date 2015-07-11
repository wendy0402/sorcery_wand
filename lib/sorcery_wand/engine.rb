require 'rails'
require File.expand_path('../../sorcery_wand.rb', __FILE__)

class SorceryWand::Engine < ::Rails::Engine
  initializer 'register_wand' do
    if SorceryWand.config.user_class.present?
      SorceryWand::Submodules.inject_submodules!
    end
  end
end
