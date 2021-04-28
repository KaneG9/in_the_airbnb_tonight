require 'booking'
require 'database_connection'

describe Booking do

  describe '#all method' do
    it "can show all bookings" do
      user = DatabaseConnection.query("INSERT INTO users(email, name, password)
      VALUES('test@email.com', 'test name', 'password') RETURNING id, name, email;")
      property = DatabaseConnection.query("INSERT INTO properties (address, postcode, title, description, price_per_day)
                                       VALUES('test address', 'test', 'testing title', 'test description', '1') 
                                       RETURNING id, postcode, title, description, price_per_day;")
      DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, property_id, renter_id, status) 
      VALUES ('2021-10-10', '2021-10-14', '#{property[0]['id']}', '#{user[0]['id']}', 'pending review') 
      RETURNING start_date, end_date, property_id, renter_id, status;")
      booking = Booking.all 
      expect(booking.first.start_date).to eq '2021-10-10'
      expect(booking.first.end_date).to eq '2021-10-14'
      expect(booking.first.property_id).to eq property[0]['id']
      expect(booking.first.renter_id).to eq user[0]['id']
      expect(booking.first.status).to eq 'pending review'
    end
  end
end
