require 'property'

describe Property do
  let(:property) {Property.new(postcode: 'E19 4RH', title: 'Dummy property listing', description: 'generic property info', price: '£100')}

  context '#initialize' do
    it 'should have attributes' do
      # expect(property.id).to eq 1
      expect(property.postcode).to eq 'E19 4RH'
      expect(property.title).to eq 'Dummy property listing'
      expect(property.description).to eq 'generic property info'
      expect(property.price).to eq '£100'
    end
  end
end
