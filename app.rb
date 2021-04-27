# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/flash'
require_relative './lib/user'

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
    if User.find(params[:email])
      flash[:error] = 'User already exists, please log in!'
    else
      user = User.create(params[:name], params[:email], params[:password])
      flash[:confirm] = "Welcome #{user.name}! Account has been created!"
    end
    redirect '/'
  end

  get '/homepage' do
    erb :homepage
  end

  post '/homepage' do
  end

  post '/session/new' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user] = user
      flash[:confirm] = "Welcome #{user.name}! Successfully logged in!"
      redirect '/homepage'
    else
      flash[:error] = 'Sorry email or password does not match!'
      redirect '/'
    end
  end

  post '/session/destroy' do
    session[:user] = nil
    flash[:confirm] = 'Successful log out'
    redirect '/'
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
