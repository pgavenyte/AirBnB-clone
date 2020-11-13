require 'date'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/setup_database'
require_relative './lib/user'
require_relative './lib/listings'
require_relative './lib/bookings'


connection

class MakersBnb < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    @logged_in = session[:user_id]
    erb :"homepage/index"
  end

  get '/users/new' do
    erb :"users/new"
  end

  post '/users' do
    user = User.add(params[:email], params[:password])
    if  User.validate(params[:password], params[:confirm_pass]) == false
      flash[:notice] = "Confirm your password."
      redirect '/users/new'
    else
      session[:user_id] = user.id
      redirect '/listings'
    end
  end

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user == nil
      flash[:notice] = 'Please check your email or password.'
      redirect '/sessions/new'
    else
      session[:user_id] = user.id
      redirect '/listings'
    end
  end

 get '/sessions/destroy' do
   erb :"sessions/destroy"
  end

  delete '/sessions' do
    flash[:notice] = "You are logged out now"
    session.delete(:user_id)
    redirect '/'
  end

  get '/listings' do
    @listings = Listings.all
    @logged_in = session[:user_id]
    erb :"listings/view"
  end

  post '/listings/filter' do
    if params[:filter_from] > params[:filter_to]
      flash[:notice] = 'Choose appropriate filter dates'
      redirect '/listings'
    else
      @filter_listings = Listings.filter(params[:filter_from], params[:filter_to])
      @logged_in = session[:user_id]
      erb :"listings/filter"
    end

  end

  get '/listings/new' do
    @logged_in = session[:user_id]
    erb :"listings/new"
  end

  post '/listings/new' do
    if params[:available_from] > params[:available_to]
      flash[:notice] = 'Choose appropriate availability dates'
      redirect '/listings/new'
    elsif session[:user_id] == nil
      flash[:notice] = 'Please login to add listing'
      redirect '/users/new'
    else
      Listings.add(people_id: session[:user_id], name: params[:name], description: params[:description], price: params[:price], available_from: params[:available_from], available_to: params[:available_to], location: params[:location])
      redirect '/listings'
    end
  end

  get '/listings/:id' do
    @logged_in = session[:user_id]
    @clicked_listing = Listings.click(id: params[:id])
    erb :"listings/id"
  end

  post '/listings/:id' do
    if session[:user_id] == nil
      flash[:notice] = 'Please login to book a space'
      redirect '/listings'
    elsif params[:date2] < params[:date1]
      flash[:notice] = 'Choose appropriate booking dates'
      redirect "/listings/#{params[:listing_id]}"
    else
      Booking.add(session[:user_id], params[:listing_id], params[:date1], params[:date2])
      flash[:notice] = 'Your request has been sent'
      redirect '/listings'
    end
  end
  get '/bookings' do
    @logged_in = session[:user_id]
    @listings = Booking.find(@logged_in)
    erb :"bookings_list/bookings_list"
  end

  get '/requests' do
    @logged_in = session[:user_id]
    @listings = Booking.requests_find(@logged_in)
    erb :"requests_list/requests_list"
  end

  run! if app_file == $0
end
