describe 'password_archivable' do
  before :all do
    redirect_stdout do
      ActiveRecord::Migrator.migrate migration_path('password_archivable')
    end
    User.reset_column_information
    sorcery_reload!
    SorceryWand.config.submodules = ['password_archivable']
    SorceryWand.config.user_class = 'User'
    SorceryWand::Submodules.inject_submodules!
  end

  after :all do
    redirect_stdout do
      ActiveRecord::Migrator.rollback migration_path('password_archivable')
    end
  end

  after :each do
    User.destroy_all
    PasswordArchive.destroy_all
  end
  let(:user) { create_new_user(username: 'wendy', email: 'test@example.com', password: 'password') }

  describe '#inject!' do
    it 'included ' do
      instance_module = SorceryWand::Submodules::PasswordArchivable::Model::InstanceMethods
      expect(User.included_modules.include?(instance_module)).to be_truthy
    end

    it 'extended' do
      class_module = SorceryWand::Submodules::PasswordArchivable::Model::ClassMethods
      expect(User.singleton_class.included_modules.include?(class_module)).to be_truthy
    end
  end

  context 'store old password' do
    before do
      SorceryWand.config.password_archivable_count = 2
      user.update_attributes(password: 'password02')
    end

    it 'into password_archives table' do
      expect(PasswordArchive.all.size).to eq(1)
    end

    it 'correctly' do
      expect(user.password_archives.first.match?('password')).to be_truthy
    end

    it 'and current user password updated' do
      expect(user.valid_password?('password02')).to be_truthy
    end
  end

  context 'total changed password more than limit' do
    before do
      SorceryWand.config.password_archivable_count = 2
      user.update_attributes(password: 'password02')
      user.update_attributes(password: "password03")
      user.update_attributes(password: "password04")
    end

    it { expect(user.password_archives.all.size).to eq(2) }

    it 'stored correctly' do
      expect(user.password_archives.order('created_at desc').first.match?('password03')).to be_truthy
    end

    it 'records more than x, destroy the oldest created' do
      expect(user.password_archives.order('created_at desc').last.match?('password')).to be_falsy
    end
  end

  context 'new password is same with any old pass' do
    before do
      token = Sorcery::Model::TemporaryToken.generate_random_token
      encrypted_password = User.encrypt('password02', token)
      PasswordArchive.create(salt: token, crypted_password: encrypted_password, user: user, created_at: Time.now)
    end
    it 'update failed' do
      expect(user.update_attributes(password: 'password02')).to be_falsy
    end

    it 'error password has been taken' do
      user.update_attributes(password: 'password02')
      expect(user.errors[:password]).to be_present
    end
  end

  context 'limit is 0' do
    before do
      SorceryWand.config.password_archivable_count = 0
      user.update_attributes(password: 'password02')
      user.update_attributes(password: "password03")
    end

    it { expect(user.password_archives.all.size).to eq(0) }

    it 'update is success' do
      expect(user.valid_password?('password03')).to be_truthy
    end

    it 'can update using old password again' do
      user.update_attributes(password: 'password02')
      expect(user.valid_password?('password02')).to be_truthy
    end
  end
end
