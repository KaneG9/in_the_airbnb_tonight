# frozen_string_literal: true

require './lib/database_connection'

def setup_test_environment
  if ENV['RACK_ENV'] == 'test'
    DatabaseConnection.setup('airbnb_test')
  else
    DatabaseConnection.setup('airbnb')
  end
end
