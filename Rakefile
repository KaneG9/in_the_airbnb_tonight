# frozen_string_literal: true

require 'pg'

task :setup do
  p 'Creating databases...'

  %w[airbnb airbnb_test].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{database};")
    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE users (id SERIAL PRIMARY KEY,
      email VARCHAR (50) UNIQUE,
      password VARCHAR (100),
      name VARCHAR (50)
    );")
    connection.exec("CREATE TABLE properties (id SERIAL PRIMARY KEY,
      address VARCHAR(100),
      postcode VARCHAR(10),
      title VARCHAR (60),
      description VARCHAR (240),
      user_id INT,
      price_per_day INT
    );")

    connection.exec("CREATE TABLE messages (id SERIAL PRIMARY KEY,
      sender_id INT,
      FOREIGN KEY (sender_id) REFERENCES users (id),
      property_id INT,
      FOREIGN KEY (property_id) REFERENCES properties (id),
      receiver_id INT,
      FOREIGN KEY (receiver_id) REFERENCES users (id),
      read BOOLEAN NOT NULL DEFAULT false,
      confirmed BOOLEAN NOT NULL DEFAULT false,
      booking_id INT
    );")

    connection.exec("CREATE TABLE bookings (id SERIAL PRIMARY KEY,
      start_date DATE,
      end_date DATE,
      property_id INT,
      FOREIGN KEY (property_id) REFERENCES properties (id),
      renter_id INT,
      FOREIGN KEY (renter_id) REFERENCES users (id),
      status VARCHAR(70)
    );")
  end
end
