require 'ammeter/init'

require File.expand_path('../../../lib/generators/sorcery_wand/install_generator', __FILE__)
describe SorceryWand::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../../dummy/tmp/test', __FILE__)

  before do
    prepare_destination
  end
  
  describe 'initializer' do
    before do
      run_generator(['--model_name', 'User'])
    end

    subject { file 'config/initializers/sorcery_wand.rb' }
    it{ is_expected.to exist }
  end

  describe 'migration' do
    before do
     run_generator(['password_archivable', '--model_name', 'User'])
    end
    subject { Dir[file('db/migrate/**/*.rb')][0] }

    it { is_expected.to exist }
    it { is_expected.to match /.*sorcery_wand_password_archivable\.rb/ }
  end
end