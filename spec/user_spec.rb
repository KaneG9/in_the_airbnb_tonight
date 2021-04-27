# frozen_string_literal: true

require 'user'
require 'pg'

describe User do
  describe '#all method' do
    it 'can list all users' do
      10.times { |n| User.create('test name', "test#{n}@email.com", 'password1234') }
      user = User.all
      expect(user.first.email).to eq 'test0@email.com'
      expect(user.first.name).to eq 'test name'
      expect(user.length).to eq 10
    end
  end

  describe '#create' do
    it 'can add a user to the db' do
      User.create('Kane', 'Kane@email.com', 'Kane_password')
      user = User.all.first
      expect(user.email).to eq 'Kane@email.com'
      expect(user.name).to eq 'Kane'
    end

    it 'hashes the password using Bcrypt' do
      expect(BCrypt::Password).to receive(:create).with('Kane_password')
      User.create('Kane', 'Kane@email.com', 'Kane_password')
    end
  end

  describe '#find method' do
    it 'can find user from database' do
      User.create('Tiffany', 'tiffany@email.com', 'tiff123')
      user = User.find('tiffany@email.com')
      expect(user.name).to eq 'Tiffany'
    end
    it 'returns nil if no matches found' do
      expect(User.find('tiffany@email.com')).to eq nil
    end
  end

  describe '#authenticate' do
    it 'returns a user if correct username + password given' do
      user = User.create('Kane', 'Kane@email.com', 'Kane_password')
      authenticated_user = User.authenticate('Kane@email.com', 'Kane_password')
      expect(user.email).to eq authenticated_user.email
    end
  end
end