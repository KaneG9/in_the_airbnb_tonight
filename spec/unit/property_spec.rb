# frozen_string_literal: true

require 'property'

describe Property do
  let(:property) do
    Property.new(id: 1, postcode: 'E19 4RH', title: 'Dummy property listing', description: 'generic property info',
                 price_per_day: 100)
  end

  context '#initialize' do
    it 'should have attributes' do
      expect(property.id).to eq 1
      expect(property.postcode).to eq 'E19 4RH'
      expect(property.title).to eq 'Dummy property listing'
      expect(property.description).to eq 'generic property info'
      expect(property.price_per_day).to eq 100
    end
  end

  context '.create' do
    it 'should create a new instance of Property' do
      property = Property.create(address: '123 fake street', postcode: 'E19 4RH', title: 'Dummy property listing',
                                 description: 'generic property info', price_per_day: 100)

      expect(property.description).to eq 'generic property info'
      expect(property.postcode).to eq 'E19 4RH'
    end
  end

  context '.all' do
    it 'should return existing properties' do
      property_1 = Property.create(address: '123 fake street', postcode: 'E19 4RH', title: 'Dummy property listing',
                                   description: 'generic property info', price_per_day: 100)
      property_2 = Property.create(address: '124 fake street', postcode: 'E20 4RH', title: 'illusion property listing',
                                   description: 'misleading property info', price_per_day: 150)

      properties = Property.all

      expect(properties.size).to eq 2
      expect(properties.first.description).to eq 'generic property info'
      expect(properties.last.description).to eq 'misleading property info'
      expect(properties.first.price_per_day).to eq 100
      expect(properties.last.price_per_day).to eq 150
    end
  end

  describe '#find' do
    it 'can find the property details from the id' do
      result = Property.create(address: '123 fake street', postcode: 'E19 4RH', title: 'Dummy property listing',
                               description: 'generic property info', price_per_day: 100)
      booking = Property.find(result.id)
      expect(booking.postcode).to eq 'E19 4RH'
      expect(booking.title).to eq 'Dummy property listing'
      expect(booking.description).to eq 'generic property info'
    end
    it 'returns nil if no matches found' do
      expect(Property.find(200)).to eq nil
    end
  end
end
