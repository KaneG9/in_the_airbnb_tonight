require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/flash'
require_relative './lib/property'


class Airbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override
  register Sinatra::Flash

  # MAKE SURE GET AND POST ARE RIGHT

  get '/' do
  end

  post '/' do
  end

  get '/homepage' do
    @properties = []
    @property = Property.new(postcode: 'E19 4RH', title: 'Dummy property listing', description: 'generic property info', price: '£100')
    @properties << @property
    p @property.postcode
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
    #need logic here to instantiate property object from database
    Property.create(postcode: params[:postcode], title: params[:title], description: params[:description], price: params[:price])
    redirect '/homepage' 
  end

  get '/property/:id' do
    
  end

  get '/property/:id/confirm' do
  end

  get '/property/:id/request' do
  end

end