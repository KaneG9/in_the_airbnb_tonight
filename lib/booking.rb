class Booking

  attr_reader :id, :start_date, :end_date, :property_id, :renter_id, :status

  def initialize(id:, start_date:, end_date:, property_id:, renter_id:, status:)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @property_id = property_id
    @renter_id = renter_id
    @status = status
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookings;')
    result.map do |booking|
      Booking.new(id: booking['id'], start_date: booking['start_date'], end_date: booking['end_date'], property_id: booking['property_id'], renter_id: booking['renter_id'], status: booking['status'])
    end
  end

end
