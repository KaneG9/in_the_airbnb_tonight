require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/flash'
require_relative './lib/user.rb'


class Airbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override
  register Sinatra::Flash

  # MAKE SURE GET AND POST ARE RIGHT

  get '/' do
    erb :index
  end

  get '/user/new' do
    erb :sign_up
  end

  post '/user/new' do
    user = User.create(params[:name], params[:email], params[:password])
    flash[:confirm] = "Welcome #{user.name}!" if user
    redirect '/'
  end

  get '/homepage' do
  end

  post '/homepage' do
  end

  get '/sessions/new' do
  end

  get '/sessions/destroy' do
  end

  get '/property/new' do
  end

  get '/property/:id' do
    
  end

  get '/property/:id/confirm' do
  end

  get '/property/:id/request' do
  end

end