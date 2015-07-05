require 'rails/generators'
module SorceryWand
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      
      desc 'Install Sorcery plugin(sorcery_wand) to the rails application'
      
      def copy_initializer
        copy_file "sorcery_wand_config.rb", "config/initializers/sorcery_wand.rb"
      end
    end
  end
end