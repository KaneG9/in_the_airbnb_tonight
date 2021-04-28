require_relative 'user'
require_relative 'property'
require_relative 'database_connection'

class Message

  attr_reader :property_owner_id, :property_id
  
  def initialize(property_owner_id:, property_id:)
    @property_owner_id = property_owner_id
    @property_id = property_id
  end

  def self.create(property_owner_id:, requested_property:)
    result = DatabaseConnection.query("INSERT INTO messages (property_owner_id, property_id)
                                      VALUES('#{property_owner_id}', '#{property_id}') 
                                      RETURNING property_owner_id, property_id;")

    Message.new(property_owner_id: result[0]['property_owner_id'], 
                property_id: result[0]['property_id'])


      #
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM messages")
    # recreate this query with SQL that pulls user data/record from owner_id field and pulls property data from property table
    result.map { |message| 
                          Message.new(property_owner_id: message[0]['property_owner_id'], 
                                      property_id: message[0]['property_id'])
  end

end
