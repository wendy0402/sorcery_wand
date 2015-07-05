require 'ammeter/init'

require File.expand_path('../../../lib/generators/sorcery_wand/install_generator', __FILE__)
describe SorceryWand::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../../dummy/tmp/test', __FILE__)

  before do
    prepare_destination
    run_generator
  end
  
  subject { file 'config/initializers/sorcery_wand.rb' }
  
  it "sorcery wand initializer exist" do
    is_expected.to exist
  end
end