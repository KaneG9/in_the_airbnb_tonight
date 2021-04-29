# frozen_string_literal: true

require_relative 'user'
require_relative 'property'
require_relative 'database_connection'

class Message
  attr_reader :id, :sender_id, :property_id, :receiver_id, :title

  def initialize(input)
    @sender_id = input[:sender_id]
    @property_id = input[:property_id]
    @receiver_id = input[:receiver_id]
    @title = input[:title] || nil
    @id = input[:id]
  end

  def self.create(sender_id:, property_id:, receiver_id:)
    result = DatabaseConnection.query("INSERT INTO messages (sender_id, property_id, receiver_id)
                                      VALUES('#{sender_id}', '#{property_id}', '#{receiver_id}')
                                      RETURNING id, sender_id, property_id, receiver_id;")

    Message.new(sender_id: result[0]['sender_id'],
                property_id: result[0]['property_id'],
                receiver_id: result[0]['receiver_id'],
                id: result[0]['id'])
  end

  def self.all(id:)
    result = DatabaseConnection.query("SELECT * FROM messages WHERE read = false AND sender_id = #{id}")
    result.map do |message|
      Message.new(sender_id: message['sender_id'],
                  property_id: message['property_id'],
                  receiver_id: message['receiver_id'],
                  id: message['id'])
    end
  end

  def self.find_rental_requests(receiver_id:)
    result = DatabaseConnection.query("SELECT * FROM properties JOIN messages ON messages.receiver_id = properties.user_id
      WHERE read = false AND receiver_id = '#{receiver_id}' AND properties.id = messages.property_id")
    result.map do |message|
      Message.new(sender_id: message['sender_id'],
                  property_id: message['property_id'],
                  receiver_id: message['receiver_id'],
                  title: message['title'],
                  id: message['id'])
    end
  end

  def self.read(id)
    result = DatabaseConnection.query("UPDATE messages
      SET read = true
      WHERE id = #{id};")
  end

  def self.confirmed_messages(receiver_id:)
    result = DatabaseConnection.query("SELECT * 
                                      FROM messages 
                                      WHERE read = false AND receiver_id = '#{receiver_id}';")
    result.map do |message|
      Message.new(sender_id: message['sender_id'],
                  property_id: message['property_id'],
                  receiver_id: message['receiver_id'],
                  id: message['id'])
    end
  end
end
