require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'pg'
require 'sinatra/flash'
require_relative 'web_helpers'
require_relative 'database_scripts'

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')



Capybara.app = Airbnb


# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  config.before(:each) do
    setup_test_environment
    clear_test_database
  end #CHANGE TEST DATABASES

  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups


end
