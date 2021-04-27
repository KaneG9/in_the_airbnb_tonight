require './lib/database_connection'

if ENV['RACK_ENV'] == 'test'
  DatabaseConnection.setup('airbnb_test')
else
  DatabaseConnection.setup('airbnb')
end
