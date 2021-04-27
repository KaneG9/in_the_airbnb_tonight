require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require_relative './lib/property'


class Airbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
  end

  enable :sessions, :method_override
  

  # MAKE SURE GET AND POST ARE RIGHT

  get '/' do
  end

  post '/' do
  end

  get '/homepage' do
    @properties = Property.all
    erb :homepage
  end

  post '/homepage' do
  end

  get '/sessions/new' do
  end

  get '/sessions/destroy' do
  end

  get '/property/new' do
    erb(:"property/new")
  end

  post '/property/new' do
    property = Property.create(address: params[:address], postcode: params[:postcode], title: params[:title], description: params[:description], price_per_day: params[:price_per_day])
    if property
      flash[:success] = 'You have successfully created a listing'
    else
      flash[:danger] = 'Something went wrong'
    end
    redirect '/homepage' 
  end

  get '/property/:id' do
    
  end

  get '/property/:id/confirm' do
  end

  get '/property/:id/request' do
  end

end