require 'rails/generators'
require 'rails/generators/migration'
module SorceryWand
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc 'Install Sorcery plugin(sorcery_wand) to the rails application'
      source_root File.expand_path('../templates', __FILE__)

      argument :submodules, optional: true, type: :array, banner: "submodules",
        desc: 'it will create submodules related migration, option: password_archivable'

      class_option :model_name, required: true, type: :string, banner: "model_name",
        desc: 'model class name for sorcery'

      #copy the initializer file to config/initializers/sorcery_wand.rb
      def copy_initializer
        copy_file "sorcery_wand_config.rb", "config/initializers/sorcery_wand.rb"
      end

      #put registered submodules to config
      def add_submodules_to_config
        if submodules
          gsub_file "config/initializers/sorcery_wand.rb", /config.submodules = \[.*\]/ do |str|
            current_submodules = (str =~ /\[(.*)\]/ ? $1 : '').gsub(' ','').split(',')
            updated_submodules = (current_submodules + submodules).uniq.to_s
            "config.submodules = #{updated_submodules}"
          end
        end
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          sleep 1 # make sure each time we get a different timestamp
          Time.new.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      # generate submodules migration
      def configure_submodules
        if submodules
          submodules.each do |submodule|
            migration_template "migration/#{submodule}.rb", "db/migrate/sorcery_wand_#{submodule}.rb"
          end
        end
      end
    end
  end
end