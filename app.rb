# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/flash'
require_relative './lib/property'
require_relative './lib/user'
require './database_connection_setup'
require './lib/booking'

class Airbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
  end

  enable :sessions, :method_override

  before do
    @user = User.find(session[:user_id])
  end

  get '/' do
    erb :index
  end

  get '/user/new' do
    erb :sign_up
  end

  post '/user/new' do
    if User.find(session[:user_id])
      flash[:error] = 'User already exists, please log in!'
    else
      user = User.create(params[:name], params[:email], params[:password])
      flash[:confirm] = "Welcome #{user.name}! Account has been created!"
    end
    redirect '/'
  end

  get '/homepage' do
    @properties = Property.all
    erb :homepage
  end

  post '/homepage' do
  end

  post '/session/new' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:confirm] = "Welcome #{user.name}! Successfully logged in!"
      redirect '/homepage'
    else
      flash[:error] = 'Sorry email or password does not match!'
      redirect '/'
    end
  end

  post '/session/destroy' do
    session[:user_id] = nil
    flash[:confirm] = 'Successful log out'
    redirect '/'
  end

  get '/property/new' do
    erb(:"property/new")
  end

  post '/property/:id/new' do
    property = Property.create(address: params[:address],
                               postcode: params[:postcode],
                               title: params[:title],
                               description: params[:description],
                               user_id: params[:id],
                               price_per_day: params[:price_per_day])
    if property
      flash[:success] = 'You have successfully created a listing'
    else
      flash[:danger] = 'Something went wrong'
    end
    redirect '/homepage'
  end

  get '/property/:id' do
    @property = Property.find(params['id'])
    @bookings = Booking.find(params['id'])
    erb :'property/id'
  end


  get '/property/:id/confirm' do
    # accept message method flips @message.read field to true, stops rendering
  end


  post '/property/:id/confirm' do
#     if message
#       flash[:success] = 'You have successfully requested to rent'
#     else
#       flash[:danger] = 'There was a problem with your requested propery'
#     end
#     redirect '/homepage'
  end

  post '/property/:id' do
    if Date.parse(params[:start_date]) < Date.today
      flash[:error] = 'The date you have requested is in the past, Please try again.'
    else
      property = Property.find(params[:id])
      message = Message.create(property_owner_id: property.user_id, property_id: params[:id], renter_id: @user.id)
      booking = Booking.create(params[:start_date],
                               params[:end_date],
                               params[:id],
                               session[:user_id],
                               'pending review')
      flash[:confirm] = 'Your rental request has been sent.'
    end
    redirect "/property/#{params[:id]}"
  end
  
end
