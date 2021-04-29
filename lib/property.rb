# frozen_string_literal: true

require_relative 'database_connection'

class Property
  attr_reader :id, :postcode, :title, :description, :price_per_day

  def initialize(id:, postcode:, title:, description:, price_per_day:)
    @id = id
    @postcode = postcode
    @title = title
    @description = description
    @price_per_day = price_per_day
  end

  # do the database stuff boyo

  def self.create(address:, postcode:, title:, description:, price_per_day:)
    result = DatabaseConnection.query("INSERT INTO properties (address, postcode, title, description, price_per_day)
                                       VALUES('#{address}', '#{postcode}', '#{title}', '#{description}', '#{price_per_day}')
                                       RETURNING id, postcode, title, description, price_per_day;")

    Property.new(id: result[0]['id'],
                 postcode: result[0]['postcode'],
                 title: result[0]['title'],
                 description: result[0]['description'],
                 price_per_day: result[0]['price_per_day'])
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM properties')
    result.map do |property|
      Property.new(id: property['id'], postcode: property['postcode'], title: property['title'],
                   description: property['description'], price_per_day: property['price_per_day'].to_i)
    end
  end

  def self.find(id)
    result = DatabaseConnection.query("SELECT * FROM properties WHERE id = #{id};")
    return unless result.any?

    Property.new(id: result[0]['id'],
                 postcode: result[0]['postcode'],
                 title: result[0]['title'],
                 description: result[0]['description'],
                 price_per_day: result[0]['price_per_day'])
  end
end
