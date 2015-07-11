$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

ENV["RAILS_ENV"] ||= 'test'

# require 'simplecov'
# SimpleCov.root File.join(File.dirname(__FILE__), '..', 'lib')
# SimpleCov.start

require 'rspec'
require 'rails/all'
require 'sorcery'
require 'rspec/rails'

require "dummy/config/environment"
require File.expand_path('../../lib/sorcery_wand.rb', __FILE__)

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each{ |f| require f }

class TestMailer < ActionMailer::Base;end


RSpec.configure do |config|
  config.mock_with :rspec

  config.use_transactional_fixtures = false
  config.before(:each) { ActionMailer::Base.deliveries.clear }

  config.before(:each) do
    SorceryWand.config = SorceryWand::Config.new
  end

  config.include ::MigrationHelper
  config.include ::Sorcery::TestHelpers::Internal
  config.include ::Sorcery::TestHelpers::Internal::Rails
  config.include ::StdioHelpers
end
