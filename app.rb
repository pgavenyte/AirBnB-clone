require_relative './lib/database_connection'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/setup_database'
require_relative './lib/user'

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

  delete '/sessions/destroyed' do
    flash[:notice] = "You are logged out now"
    session.delete(:user_id)
    redirect '/sessions/new'
  end
end
