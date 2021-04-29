require 'booking'
require 'database_connection'

describe Booking do
  before(:each) do
    @user = DatabaseConnection.query("INSERT INTO users(email, name, password)
      VALUES('test@email.com', 'test name', 'password') RETURNING id, name, email;")
    @property = DatabaseConnection.query("INSERT INTO properties (address, postcode, title, description, price_per_day)
                                      VALUES('test address', 'test', 'testing title', 'test description', '1') 
                                       RETURNING id, postcode, title, description, price_per_day;")
  end

  describe '#all method' do
    it "can show all bookings" do
      Booking.create('2021-10-10', '2021-10-14', "#{@property[0]['id']}", "#{@user[0]['id']}", 'pending review')
      booking = Booking.all 
      expect(booking.first.start_date).to eq '2021-10-10'
      expect(booking.first.end_date).to eq '2021-10-14'
      expect(booking.first.property_id).to eq @property[0]['id']
      expect(booking.first.renter_id).to eq @user[0]['id']
      expect(booking.first.status).to eq 'pending review'
    end
  end

  describe '#create' do 
    it 'can add a booking to db' do
      Booking.create('2021-10-10', '2021-10-14', "#{@property[0]['id']}", "#{@user[0]['id']}", 'pending review')
      booking = Booking.all 
      expect(booking.first.start_date).to eq '2021-10-10'
      expect(booking.first.end_date).to eq '2021-10-14'
      expect(booking.first.property_id).to eq @property[0]['id']
      expect(booking.first.renter_id).to eq @user[0]['id']
      expect(booking.first.status).to eq 'pending review'
    end
  end

  describe '#find' do
    it 'can find the booking details from the id' do
      result = Booking.create('2021-10-10', '2021-10-14', "#{@property[0]['id']}", "#{@user[0]['id']}", 'pending review')
      booking = Booking.find(result.property_id)
      expect(booking.first.start_date).to eq '2021-10-10'
      expect(booking.first.end_date).to eq '2021-10-14'
      expect(booking.first.property_id).to eq @property[0]['id']
      expect(booking.first.renter_id).to eq @user[0]['id']
      expect(booking.first.status).to eq 'pending review'
    end
    it 'returns nil if no matches found' do
      expect(Booking.find(200)).to eq nil
    end
  end

end
