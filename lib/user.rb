require 'pg'
require 'bcrypt'

class User

  attr_reader :name, :email

  def initialize(name:, email:)
    @name = name
    @email = email
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'airbnb_test')
    else
      connection = PG.connect(dbname: 'airbnb')
    end

    result = connection.exec('SELECT * FROM users;')
    result.map do |user|
      User.new(name: user['name'], email: user['email'])
    end
  end

  def self.create(name, email, password)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'airbnb_test')
    else
      connection = PG.connect(dbname: 'airbnb')
    end
    encrypted_password = BCrypt::Password.create(password)
    result = connection.exec("INSERT INTO users(email, name, password) VALUES('#{email}', '#{name}', '#{encrypted_password}') RETURNING name, email;")
    User.new(name: result[0]['name'], email: result[0]['email'])
  end

  def self.find(email)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'airbnb_test')
    else
      connection = PG.connect(dbname: 'airbnb')
    end
    result  = connection.exec("SELECT * FROM users WHERE email = '#{email}';")
    User.new(name: result[0]['name'], email: result[0]['email'])
  end

  def self.authenticate(email, password)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'airbnb_test')
    else
      connection = PG.connect(dbname: 'airbnb')
    end
    result  = connection.exec("SELECT * FROM users WHERE email = '#{email}';")
    
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password
    User.new(name: result[0]['name'], email: result[0]['email'])
  end

end