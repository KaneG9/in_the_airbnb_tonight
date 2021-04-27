require 'pg'

class User

  attr_reader :name, :email, :password

  def initialize(name:, email:, password:)
    @name = name
    @email = email
    @password = password
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'airbnb_test')
    else
      connection = PG.connect(dbname: 'airbnb')
    end

    result = connection.exec('SELECT * FROM users;')
    result.map do |user|
      User.new(name: user['name'], email: user['email'], password: user['password'])
    end
  end
  

end