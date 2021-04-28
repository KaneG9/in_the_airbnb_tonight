# frozen_string_literal: true

require 'pg'
require 'bcrypt'
require './database_connection_setup'

class User
  attr_reader :id, :name, :email

  def initialize(id:, name:, email:)
    @id = id
    @name = name
    @email = email
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM users;')
    result.map do |user|
      User.new(id: user['id'], name: user['name'], email: user['email'])
    end
  end

  def self.create(name, email, password)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users(email, name, password)
    VALUES('#{email}', '#{name}', '#{encrypted_password}') RETURNING id, name, email;")
    User.new(id: result[0]['id'], name: result[0]['name'], email: result[0]['email'])
  end

  def self.find(id)
    return nil unless id
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}';")

    User.new(id: result[0]['id'], name: result[0]['name'], email: result[0]['email'])
  end

  def self.authenticate(email, password)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';")

    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password

    User.new(id: result[0]['id'], name: result[0]['name'], email: result[0]['email'])
  end
end
