# frozen_string_literal: true

require_relative 'user'
require_relative 'property'
require_relative 'database_connection'

class Message
  attr_reader :property_owner_id, :property_id, :renter_id, :title

  def initialize(input)
    @property_owner_id = input[:property_owner_id]
    @property_id = input[:property_id]
    @renter_id = input[:renter_id]
    @title = input[:title] || nil
  end

  def self.create(property_owner_id:, property_id:, renter_id:)
    result = DatabaseConnection.query("INSERT INTO messages (property_owner_id, property_id, renter_id)
                                      VALUES('#{property_owner_id}', '#{property_id}', '#{renter_id}')
                                      RETURNING property_owner_id, property_id, renter_id;")

    Message.new(property_owner_id: result[0]['property_owner_id'],
                property_id: result[0]['property_id'],
                renter_id: result[0]['renter_id'])
  end

  def self.all(id:)
    result = DatabaseConnection.query("SELECT * FROM messages WHERE read = false AND property_owner_id = #{id}")
    result.map do |message|
      Message.new(property_owner_id: message['property_owner_id'],
                  property_id: message['property_id'],
                  renter_id: message['renter_id'])
    end
  end

  def self.join_properties(property_owner_id:)
    result = DatabaseConnection.query("SELECT * FROM properties JOIN messages ON messages.property_owner_id = properties.user_id
      WHERE read = false AND property_owner_id = '#{property_owner_id}' AND properties.id = messages.property_id")
    result.map do |message|
      Message.new(property_owner_id: message['property_owner_id'],
                  property_id: message['property_id'],
                  renter_id: message['renter_id'],
                  title: message['title'])
    end

  end
end
