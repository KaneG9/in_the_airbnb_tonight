require 'message'

describe Message do
  
  context '.create' do
    it 'should create a new instance of message' do
      owner = User.create('test name', "test@email.com", 'password1234')
      property = Property.create(address: '123 fake street', postcode: 'E19 4RH', title: 'Dummy property listing', description: 'generic property info', user_id: owner.id, price_per_day: 100)
      message = Message.create(property_owner_id: property.user_id, property_id: property.id)

      expect(message.property_owner_id).to eq property.user_id
      expect(message.property_id).to eq property.id

    end
  end
end