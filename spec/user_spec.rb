require 'user'
require 'pg'

describe User do

  describe '#all method' do
    it "can list all users" do
      connection = PG.connect(dbname: 'airbnb_test')
      connection.exec("INSERT INTO users(email,name,password) VALUES('test@email.com', 'test name', 'password1234');")
      user = User.all.first
      expect(user.email).to eq 'test@email.com'
      expect(user.name).to eq 'test name'
      expect(user.password).to eq 'password1234'
    end
  end      

end