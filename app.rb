# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/flash'
require_relative './lib/property'
require_relative './lib/user'
require './database_connection_setup'
require './lib/booking'
require './lib/message'

class Airbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
  end

  enable :sessions, :method_override

  before do
    @user = User.find(column: 'id', value: session[:user_id])
  end

  get '/' do
    erb :index
  end

  get '/user/new' do
    erb :sign_up
  end

  post '/user/new' do
    if User.find(column: 'email', value: params[:email])
      flash[:error] = 'User already exists, please log in!'
    else
      user = User.create(params[:name], params[:email], params[:password])
      flash[:confirm] = "Welcome #{user.name}! Account has been created!"
    end
    redirect '/'
  end

  get '/homepage' do
    @properties = Property.all
    @request_messages = Message.find_rental_requests(receiver_id: @user.id)
    @confirmed_messages = Message.confirmed_messages(receiver_id: @user.id)
    erb :homepage
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

  post '/property/new' do
    property = Property.create(address: params[:address],
                               postcode: params[:postcode],
                               title: params[:title],
                               description: params[:description],
                               user_id: params[:user_id],
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

  post '/property/:id/accept_confirmation' do
    Message.read(params[:message_id])
    redirect "/property/#{params[:id]}"
  end

  post '/property/:id' do
    if Date.parse(params[:start_date]) < Date.today
      flash[:error] = 'The date you have requested is in the past, Please try again.'
    else
      property = Property.find(params[:id])
      booking = Booking.create(params[:start_date],
                               params[:end_date],
                               params[:id],
                               session[:user_id],
                               'pending review')
      message = Message.create(sender_id: @user.id, 
                              property_id: params[:id], 
                              receiver_id: property.user_id,
                              confirmed: false,
                              booking_id: booking.id)
      flash[:confirm] = 'Your rental request has been sent.'
    end
    redirect "/property/#{params[:id]}"
  end

  post '/property/:id/confirm' do
    Message.read(params[:message_id])
    Message.create(sender_id: @user.id, 
                  property_id: params[:id], 
                  receiver_id: params[:sender_id],
                  confirmed: true,
                  booking_id: params[:booking_id])
    Booking.update_status(params[:booking_id])
    #booking status updated to confirmed
    redirect '/homepage'
  end

  
end
