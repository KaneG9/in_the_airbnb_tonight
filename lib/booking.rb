# frozen_string_literal: true

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
      Booking.new(id: booking['id'],
                  start_date: booking['start_date'],
                  end_date: booking['end_date'],
                  property_id: booking['property_id'],
                  renter_id: booking['renter_id'],
                  status: booking['status'])
    end
  end

  def self.create(start_date, end_date, property_id, renter_id, status)
    booking = DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, property_id, renter_id, status)
      VALUES ('#{start_date}', '#{end_date}', '#{property_id}', '#{renter_id}', '#{status}')
      RETURNING id, start_date, end_date, property_id, renter_id, status;")
    Booking.new(id: booking[0]['id'],
                start_date: booking[0]['start_date'],
                end_date: booking[0]['end_date'],
                property_id: booking[0]['property_id'],
                renter_id: booking[0]['renter_id'],
                status: booking[0]['status'])
  end

  def self.find(property_id)
    result = DatabaseConnection.query("SELECT *
      FROM bookings
      WHERE property_id = #{property_id} AND start_date >= DATE(NOW())
      ORDER BY start_date ASC;")
    return unless result.any?

    result.map do |booking|
      Booking.new(id: booking['id'],
                  start_date: booking['start_date'],
                  end_date: booking['end_date'],
                  property_id: booking['property_id'],
                  renter_id: booking['renter_id'],
                  status: booking['status'])
    end
  end

  def self.update_status(id)
    DatabaseConnection.query("UPDATE bookings
      SET status = 'Booking confirmed'
      WHERE id = #{id};")
  end
end
