# frozen_string_literal: true

require 'message'

describe Message do
  context '.create' do
    it 'should create a new instance of message' do
      renter = User.create('rent test name', 'rent@email.com', 'password1234')
      owner = User.create('test name', 'test@email.com', 'password1234')
      property = Property.create(address: '123 fake street',
                                 postcode: 'E19 4RH',
                                 title: 'Dummy property listing',
                                 description: 'generic property info',
                                 user_id: owner.id,
                                 price_per_day: 100)

      message = Message.create(property_owner_id: property.user_id,
                               property_id: property.id,
                               renter_id: renter.id)

      expect(message.property_owner_id).to eq property.user_id
      expect(message.property_id).to eq property.id
    end
  end

  context '.all' do
    it 'should return existing messages' do
      renter = User.create('rent test name', 'rent@email.com', 'password1234')
      owner = User.create('test name', 'test@email.com', 'password1234')
      property_1 = Property.create(address: '123 fake street',
                                   postcode: 'E19 4RH',
                                   title: 'Dummy property listing',
                                   description: 'generic property info',
                                   user_id: owner.id,
                                   price_per_day: 100)
      message = Message.create(property_owner_id: property_1.user_id,
                               property_id: property_1.id,
                               renter_id: renter.id)
      messages = Message.all

      expect(messages.size).to eq 1
      expect(messages.first.property_owner_id).to eq owner.id
      expect(messages.first.property_id).to eq property_1.id

      # converts to integer to be stored for easy manipulation and calculation, can interpolate into views. possibly change to string?
    end
  end
end
