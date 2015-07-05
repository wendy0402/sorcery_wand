$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

ENV["RAILS_ENV"] ||= 'test'

# require 'simplecov'
# SimpleCov.root File.join(File.dirname(__FILE__), '..', 'lib')
# SimpleCov.start

require 'rspec'
require 'sorcery'
require 'rails/all'
require 'rspec/rails'
require 'timecop'

require "rails_app/config/environment"

class TestMailer < ActionMailer::Base;end


RSpec.configure do |config|
  config.mock_with :rspec

  config.use_transactional_fixtures = false 
  config.before(:each) { ActionMailer::Base.deliveries.clear }
end
