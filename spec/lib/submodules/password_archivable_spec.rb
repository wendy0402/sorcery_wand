describe 'password_archivable' do
  before :all do
    ActiveRecord::Migrator.migrate migration_path('password_archivable')
    User.reset_column_information
    sorcery_reload!([:password_archivable])
  end

  after :all do
    ActiveRecord::Migrator.rollback migration_path('password_archivable')
  end

  let(:user) { create_new_user }

  describe 'configuration' do
    it 'password_archiving_count' do
      sorcery_model_property_set(:password_archiving_count, 5)
      expect(User.sorcery_config.password_archiving_count).to eq 5
    end
  end
end
