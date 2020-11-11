require_relative './lib/database_connection'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/setup_database'
require_relative './lib/user'
require_relative './lib/listings'

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
    if  User.validate(params[:password], params[:confirm_pass]) == false
      flash[:notice] = "Confirm your password."
      redirect '/users/new'
    else
      User.add(params[:email], params[:password])
    end
  end

  get '/listings' do
    @listings = Listings.all
    erb :"listings/view"
  end

  post '/listings/filter' do
    @from = params[:filter_from]
    @to = params[:filter_to]
    p params
    @filter_listings = Listings.filter(@from, @to)
    erb(:"listings/filter")
    #redirect '/listings/filter'
  end

  get '/listings/filter' do
    #@from = params[:filter_from]
    #@to = params[:filter_to]
    p params
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
