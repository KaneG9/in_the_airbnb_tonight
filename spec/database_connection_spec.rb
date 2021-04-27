require 'database_connection'

describe DatabaseConnection do

  describe '#setup' do
    it 'can setup the database' do
      expect(PG).to receive(:connect).with(dbname: 'airbnb_test')
      DatabaseConnection.setup('airbnb_test')
    end
  end

  describe '#connection' do
    it 'can connect and stay connected' do
      connection = DatabaseConnection.setup('airbnb_test')
      expect(DatabaseConnection.connection).to eq connection
    end
  end

  describe '#query' do
    it 'can run the db query using PG gem' do
      connection = DatabaseConnection.setup('airbnb_test')
      expect(connection).to receive(:exec).with("SELECT * FROM users;")
      DatabaseConnection.query("SELECT * FROM users;")
    end
  end
      
end

