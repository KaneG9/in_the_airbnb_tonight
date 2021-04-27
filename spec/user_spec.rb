require 'user'
require 'pg'

describe User do

  describe '#all method' do
    it "can list all users" do
      10.times { |n| User.create('test name', "test#{n}@email.com", 'password1234') }
      user = User.all
      expect(user.first.email).to eq 'test0@email.com'
      expect(user.first.name).to eq 'test name'
      expect(user.first.password).to eq 'password1234'
      expect(user.length).to eq 10
    end
  end   
  
  describe '#create' do
    it 'can add a user to the db' do
      User.create('Kane', 'Kane@email.com', 'Kane_password')
      user = User.all.first
      expect(user.email).to eq 'Kane@email.com'
      expect(user.name).to eq 'Kane'
      expect(user.password).to eq 'Kane_password'
    end
  end

end