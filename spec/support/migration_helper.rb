module MigrationHelper
  def migration_path(submodule)
    "#{Rails.root}/db/migrate/#{submodule}"
  end
end
