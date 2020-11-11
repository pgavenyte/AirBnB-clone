require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/setup_database'
require_relative './lib/user'
require_relative './lib/listings'

connection

class MakersBnb < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    "Hello World."
  end

  get '/users/new' do
    erb(:"users/new")
  end

  post '/users' do
    user = User.add(params[:email], params[:password])
    if  User.validate(params[:password], params[:confirm_pass]) == false
      flash[:notice] = "Confirm your password."
      redirect '/users/new'
    else
      session[:user_id] = user.id
    end
  end

  get '/sessions/new' do
    erb(:"sessions/new")
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user == nil
      flash[:notice] = 'Please check your email or password.'
      redirect '/sessions/new'
    else
      session[:user_id] = user.id
    end
  end

 get '/sessions/destroy' do
   erb(:"sessions/destroy")
  end

  delete '/sessions' do
    flash[:notice] = "You are logged out now"
    session.delete(:user_id)
    redirect '/sessions/new'
  end

  get '/listings' do
    @listings = Listings.all
    erb :"listings/view"
  end

  post '/listings/filter' do
    @from = params[:filter_from]
    @to = params[:filter_to]
    @filter_listings = Listings.filter(@from, @to)
    erb(:"listings/filter")
  end

  get '/listings/new' do
    erb(:"listings/new")
  end

  post '/listings/new' do
    Listings.add(name: params[:name], description: params[:description], price: params[:price], available_from: params[:available_from], available_to: params[:available_to], location: params[:location])
    redirect '/listings'
  end

  run! if app_file == $0
end
