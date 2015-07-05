module MigrationHelper
  def migration_path(submodule)
    File.expand_path("../../lib/generators/sorcery_wand/templates/migration/#{submodule}",__FILE__)
  end
end