require_relative 'user'
require_relative 'property'
require_relative 'database_connection'

class Message

  attr_reader :property_owner_id, :property_id, :renter_id
  
  def initialize(property_owner_id:, property_id:, renter_id:)
    @property_owner_id = property_owner_id
    @property_id = property_id
    @renter_id = renter_id
  end

  def self.create(property_owner_id:, property_id:, renter_id:)
    result = DatabaseConnection.query("INSERT INTO messages (property_owner_id, property_id, renter_id)
                                      VALUES('#{property_owner_id}', '#{property_id}', '#{renter_id}') 
                                      RETURNING property_owner_id, property_id, renter_id;")

    Message.new(property_owner_id: result[0]['property_owner_id'], 
                property_id: result[0]['property_id'],
                renter_id: result[0]['renter_id'])
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM messages WHERE read is false")
    result.map { |message| 
                          Message.new(property_owner_id: message['property_owner_id'], 
                                      property_id: message['property_id'],
                                      renter_id: message['renter_id']) }
  end
end
