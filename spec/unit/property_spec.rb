require 'property'

describe Property do
  let(:property) {Property.new(id: 1, postcode: 'E19 4RH', title: 'Dummy property listing', description: 'generic property info', price_per_day: 100)}

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
      property = Property.create(address: '123 fake street', postcode: 'E19 4RH', title: 'Dummy property listing', description: 'generic property info', price_per_day: 100)

      expect(property.description).to eq 'generic property info'
      expect(property.postcode).to eq 'E19 4RH'
    end
  end
end
