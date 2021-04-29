# frozen_string_literal: true

require 'message'

describe Message do
  context '.create' do
    it 'should create a new instance of message' do
      receiver = User.create('rent test name', 'rent@email.com', 'password1234')
      owner = User.create('test name', 'test@email.com', 'password1234')
      property = Property.create(address: '123 fake street',
                                 postcode: 'E19 4RH',
                                 title: 'Dummy property listing',
                                 description: 'generic property info',
                                 user_id: owner.id,
                                 price_per_day: 100)

      message = Message.create(sender_id: property.user_id,
                               property_id: property.id,
                               receiver_id: receiver.id)

      expect(message.sender_id).to eq property.user_id
      expect(message.property_id).to eq property.id
    end
  end

  context '.all' do
    it 'should return existing messages' do
      receiver = User.create('rent test name', 'rent@email.com', 'password1234')
      owner = User.create('test name', 'test@email.com', 'password1234')
      property_1 = Property.create(address: '123 fake street',
                                   postcode: 'E19 4RH',
                                   title: 'Dummy property listing',
                                   description: 'generic property info',
                                   user_id: owner.id,
                                   price_per_day: 100)
      message = Message.create(sender_id: property_1.user_id,
                               property_id: property_1.id,
                               receiver_id: receiver.id)
      messages = Message.all(id: property_1.user_id)

      expect(messages.size).to eq 1
      expect(messages.first.sender_id).to eq owner.id
      expect(messages.first.property_id).to eq property_1.id

      # converts to integer to be stored for easy manipulation and calculation, can interpolate into views. possibly change to string?
    end
  end

  context '.find_rental_requests' do
    it 'should returning an owners message with property details' do
      renter = User.create('rent test name', 'rent@email.com', 'password1234')
      owner = User.create('test name', 'test@email.com', 'password1234')
      property_1 = Property.create(address: '123 fake street',
                                   postcode: 'E19 4RH',
                                   title: 'Dummy property listing',
                                   description: 'generic property info',
                                   user_id: owner.id,
                                   price_per_day: 100)
      message = Message.create(sender_id: renter.id,
                               property_id: property_1.id,
                               receiver_id: property_1.user_id)

      messages = Message.find_rental_requests(receiver_id: property_1.user_id)
      expect(messages.size).to eq 1
      expect(messages.first.sender_id).to eq renter.id
      expect(messages.first.receiver_id).to eq property_1.user_id
      expect(messages.first.title).to eq 'Dummy property listing'

      # converts to integer to be stored for easy manipulation and calculation, can interpolate into views. possibly change to string?
    end
  end

  context '.confirmed_message' do
    it 'gathers confirmed messages for renter' do
      renter = User.create('rent test name', 'rent@email.com', 'password1234')
      owner = User.create('test name', 'test@email.com', 'password1234')
      property_1 = Property.create(address: '123 fake street',
                                   postcode: 'E19 4RH',
                                   title: 'Dummy property listing',
                                   description: 'generic property info',
                                   user_id: owner.id,
                                   price_per_day: 100)
      message = Message.create(sender_id: property_1.user_id,
                               property_id: property_1.id,
                               receiver_id: renter.id)

      messages = Message.confirmed_messages(receiver_id: renter.id)
      expect(messages.size).to eq 1
      expect(messages.first.sender_id).to eq property_1.user_id
      expect(messages.first.receiver_id).to eq renter.id
    end
  end
    
end
