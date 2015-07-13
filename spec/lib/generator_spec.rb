require 'ammeter/init'

require File.expand_path('../../../lib/generators/sorcery_wand/install_generator', __FILE__)
describe SorceryWand::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../../dummy/tmp/test', __FILE__)

  before do
    prepare_destination
    example_app = Rails.root
    %w(config bin).each do |dir|
      `cp -r #{example_app.to_s + '/' + dir} #{destination_root}`
    end
  end

  after(:each) do
    f = file './'
    FileUtils.rm_rf(f)
  end

  describe 'initialize only' do
    before do
      run_generator(['--model_name', 'User'])
    end

    subject { file 'config/initializers/sorcery_wand.rb' }
    it{ is_expected.to exist }

    it 'not include submodules' do
      is_expected.to_not contain '["password_archivable"]'
    end

    it 'include user class' do
      is_expected.to contain "config.user_class = 'User'\nend"
    end
  end

  # describe 'submodules password_archivable' do
  #   before :each do
  #     model_path = Rails.root + 'app/models'
  #     FileUtils.mv("#{model_path}/password_archive.rb", "#{model_path}/password_archive2.rb")
  #     FileUtils.ln_s("#{Rails.root}/app", "#{destination_root}")
  #    run_generator(['password_archivable', '--model_name', 'User'])
  #   end
  #
  #   after :each do
  #     model_path = Rails.root + 'app/models'
  #     FileUtils.mv("#{model_path}/password_archive2.rb", "#{model_path}/password_archive.rb")
  #   end
  #
  #   it { expect(file('db/migrate/sorcery_wand_password_archivable.rb')).to be_a_migration }
  #
  #   it 'config include submodules' do
  #     expect(file('config/initializers/sorcery_wand.rb')).to contain '["password_archivable"]'
  #   end
  # end
end
